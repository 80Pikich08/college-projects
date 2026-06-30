import argparse
import getpass
import os
import shutil
import subprocess
from datetime import datetime
from pathlib import Path


SEED_20_BOOKINGS_SQL = r"""
TRUNCATE TABLE
    booking_items,
    bookings,
    clients,
    client_booking_statistics
RESTART IDENTITY CASCADE;

DO $$
DECLARE
    service_id_1 BIGINT;
    service_id_2 BIGINT;
    tariff_id_1 BIGINT;
    tariff_id_2 BIGINT;

    current_client_id BIGINT;
    current_booking_id BIGINT;

    client_index INTEGER;
    i INTEGER;
BEGIN
    SELECT id
    INTO service_id_1
    FROM services
    WHERE is_active = true
    ORDER BY id
    LIMIT 1;

    SELECT id
    INTO service_id_2
    FROM services
    WHERE is_active = true
    ORDER BY id
    OFFSET 1
    LIMIT 1;

    IF service_id_1 IS NULL THEN
        INSERT INTO services (
            title,
            slug,
            short_description,
            description,
            is_active,
            sort_order,
            created_at,
            updated_at
        )
        VALUES (
            'Тестовая фотосъёмка',
            'testovaya-fotosyomka',
            'Тестовая услуга для заявок.',
            'Тестовая услуга для заполнения базы данных.',
            true,
            1,
            NOW(),
            NOW()
        )
        RETURNING id INTO service_id_1;
    END IF;

    IF service_id_2 IS NULL THEN
        service_id_2 := service_id_1;
    END IF;

    SELECT id
    INTO tariff_id_1
    FROM tariffs
    WHERE service_id = service_id_1
      AND is_active = true
    ORDER BY id
    LIMIT 1;

    IF tariff_id_1 IS NULL THEN
        INSERT INTO tariffs (
            service_id,
            title,
            price,
            old_price,
            duration_minutes,
            photos_count,
            description,
            features,
            is_popular,
            is_active,
            sort_order,
            created_at,
            updated_at
        )
        VALUES (
            service_id_1,
            'Базовый',
            2500,
            NULL,
            60,
            10,
            'Тестовый базовый тариф.',
            '- 1 образ' || E'\n' || '- 10 фото' || E'\n' || '- Цветокоррекция',
            false,
            true,
            1,
            NOW(),
            NOW()
        )
        RETURNING id INTO tariff_id_1;
    END IF;

    SELECT id
    INTO tariff_id_2
    FROM tariffs
    WHERE service_id = service_id_2
      AND is_active = true
    ORDER BY id
    LIMIT 1;

    IF tariff_id_2 IS NULL THEN
        INSERT INTO tariffs (
            service_id,
            title,
            price,
            old_price,
            duration_minutes,
            photos_count,
            description,
            features,
            is_popular,
            is_active,
            sort_order,
            created_at,
            updated_at
        )
        VALUES (
            service_id_2,
            'Расширенный',
            4500,
            NULL,
            120,
            20,
            'Тестовый расширенный тариф.',
            '- 2 образа' || E'\n' || '- 20 фото' || E'\n' || '- Ретушь',
            true,
            true,
            2,
            NOW(),
            NOW()
        )
        RETURNING id INTO tariff_id_2;
    END IF;

    FOR i IN 1..5 LOOP
        INSERT INTO clients (
            name,
            phone,
            email,
            messenger,
            created_at,
            updated_at
        )
        VALUES (
            'Клиент ' || i,
            '+790000000' || LPAD(i::text, 2, '0'),
            'client' || i || '@example.com',
            '@client' || i,
            NOW(),
            NOW()
        );
    END LOOP;

    FOR i IN 1..20 LOOP
        client_index := ((i - 1) % 5) + 1;

        SELECT id
        INTO current_client_id
        FROM clients
        WHERE phone = '+790000000' || LPAD(client_index::text, 2, '0');

        INSERT INTO bookings (
            client_id,
            client_name,
            client_phone,
            client_email,
            client_messenger,
            preferred_at,
            comment,
            status,
            created_at,
            updated_at
        )
        VALUES (
            current_client_id,
            'Клиент ' || client_index,
            '+790000000' || LPAD(client_index::text, 2, '0'),
            'client' || client_index || '@example.com',
            '@client' || client_index,
            NOW() + (i || ' days')::interval,
            'Тестовая заявка номер ' || i,
            CASE
                WHEN i % 5 = 0 THEN 'completed'
                WHEN i % 4 = 0 THEN 'confirmed'
                WHEN i % 3 = 0 THEN 'contacted'
                ELSE 'new'
            END,
            NOW(),
            NOW()
        )
        RETURNING id INTO current_booking_id;

        INSERT INTO booking_items (
            booking_id,
            service_id,
            tariff_id,
            created_at,
            updated_at
        )
        VALUES (
            current_booking_id,
            service_id_1,
            tariff_id_1,
            NOW(),
            NOW()
        );

        IF i % 2 = 0 THEN
            INSERT INTO booking_items (
                booking_id,
                service_id,
                tariff_id,
                created_at,
                updated_at
            )
            VALUES (
                current_booking_id,
                service_id_2,
                tariff_id_2,
                NOW(),
                NOW()
            );
        END IF;
    END LOOP;
END;
$$;

CALL refresh_client_booking_statistics(NULL);

SELECT
    client_name,
    client_phone,
    bookings_count,
    last_booking_at,
    calculated_at
FROM client_booking_statistics
ORDER BY bookings_count DESC, client_name ASC;
"""


def get_tool_name(name: str) -> str:
    if os.name == "nt":
        return f"{name}.exe"
    return name


def find_pg_tool(name: str, pg_bin: str | None) -> str:
    tool_name = get_tool_name(name)

    if pg_bin:
        candidate = Path(pg_bin) / tool_name
        if candidate.exists():
            return str(candidate)

    found = shutil.which(tool_name)
    if found:
        return found

    if os.name == "nt":
        common_roots = [
            r"C:\Program Files\PostgreSQL\17\bin",
            r"C:\Program Files\PostgreSQL\16\bin",
            r"C:\Program Files\PostgreSQL\15\bin",
            r"C:\Program Files\PostgreSQL\14\bin",
        ]

        for root in common_roots:
            candidate = Path(root) / tool_name
            if candidate.exists():
                return str(candidate)

    raise FileNotFoundError(
        f"Не найдена утилита PostgreSQL: {tool_name}. "
        f"Добавьте PostgreSQL bin в PATH или укажите --pg-bin."
    )


def run_command(command: list[str], password: str | None = None) -> None:
    env = os.environ.copy()

    if password:
        env["PGPASSWORD"] = password

    print()
    print("Running:")
    print(" ".join(command))
    print()

    subprocess.run(command, check=True, env=env)


def run_sql_file(
    psql: str,
    sql_file: Path,
    db_name: str,
    user: str,
    host: str,
    port: str,
    password: str | None,
) -> None:
    command = [
        psql,
        "--host",
        host,
        "--port",
        port,
        "--username",
        user,
        "--dbname",
        db_name,
        "--set",
        "ON_ERROR_STOP=on",
        "--file",
        str(sql_file),
    ]

    run_command(command, password)


def backup_database(args: argparse.Namespace) -> None:
    pg_dump = find_pg_tool("pg_dump", args.pg_bin)

    backup_dir = Path(args.backup_dir)
    backup_dir.mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_file = backup_dir / f"{args.db}_backup_{timestamp}.sql"

    command = [
        pg_dump,
        "--host",
        args.host,
        "--port",
        args.port,
        "--username",
        args.user,
        "--format",
        "plain",
        "--clean",
        "--if-exists",
        "--no-owner",
        "--no-privileges",
        "--encoding",
        "UTF8",
        "--file",
        str(backup_file),
        args.db,
    ]

    run_command(command, args.password)

    print()
    print("Backup created:")
    print(backup_file)


def restore_database(args: argparse.Namespace) -> None:
    psql = find_pg_tool("psql", args.pg_bin)
    dropdb = find_pg_tool("dropdb", args.pg_bin)
    createdb = find_pg_tool("createdb", args.pg_bin)

    backup_file = Path(args.backup_file)

    if not backup_file.exists():
        raise FileNotFoundError(f"Файл бэкапа не найден: {backup_file}")

    escaped_db_name = args.db.replace("'", "''")

    terminate_command = [
        psql,
        "--host",
        args.host,
        "--port",
        args.port,
        "--username",
        args.user,
        "--dbname",
        "postgres",
        "--command",
        (
            "SELECT pg_terminate_backend(pid) "
            "FROM pg_stat_activity "
            f"WHERE datname = '{escaped_db_name}' "
            "AND pid <> pg_backend_pid();"
        ),
    ]

    run_command(terminate_command, args.password)

    drop_command = [
        dropdb,
        "--host",
        args.host,
        "--port",
        args.port,
        "--username",
        args.user,
        "--if-exists",
        args.db,
    ]

    run_command(drop_command, args.password)

    create_command = [
        createdb,
        "--host",
        args.host,
        "--port",
        args.port,
        "--username",
        args.user,
        args.db,
    ]

    run_command(create_command, args.password)

    run_sql_file(
        psql=psql,
        sql_file=backup_file,
        db_name=args.db,
        user=args.user,
        host=args.host,
        port=args.port,
        password=args.password,
    )

    print()
    print("Database restored successfully.")


def seed_20_bookings(args: argparse.Namespace) -> None:
    psql = find_pg_tool("psql", args.pg_bin)

    temp_dir = Path("storage") / "app"
    temp_dir.mkdir(parents=True, exist_ok=True)

    temp_sql_file = temp_dir / "seed_20_bookings.generated.sql"
    temp_sql_file.write_text(SEED_20_BOOKINGS_SQL, encoding="utf-8")

    run_sql_file(
        psql=psql,
        sql_file=temp_sql_file,
        db_name=args.db,
        user=args.user,
        host=args.host,
        port=args.port,
        password=args.password,
    )

    print()
    print("20 test bookings created successfully.")


def add_common_db_arguments(parser: argparse.ArgumentParser) -> None:
    parser.add_argument("--db", default="photostudio", help="Название базы данных")
    parser.add_argument("--user", default="postgres", help="Пользователь PostgreSQL")
    parser.add_argument("--host", default="127.0.0.1", help="Хост PostgreSQL")
    parser.add_argument("--port", default="5432", help="Порт PostgreSQL")
    parser.add_argument(
        "--password",
        default=None,
        help="Пароль PostgreSQL. Если не указать, скрипт спросит пароль.",
    )
    parser.add_argument(
        "--pg-bin",
        default=None,
        help=(
            "Путь к папке bin PostgreSQL. "
            "Windows пример: C:\\Program Files\\PostgreSQL\\17\\bin"
        ),
    )


def main() -> None:
    parser = argparse.ArgumentParser(
        description="PostgreSQL backup/restore/seed tools for photostudio project"
    )

    subparsers = parser.add_subparsers(dest="command", required=True)

    backup_parser = subparsers.add_parser("backup", help="Создать бэкап базы")
    add_common_db_arguments(backup_parser)
    backup_parser.add_argument(
        "--backup-dir",
        default="backups",
        help="Папка для сохранения бэкапов",
    )
    backup_parser.set_defaults(func=backup_database)

    restore_parser = subparsers.add_parser("restore", help="Восстановить базу из бэкапа")
    add_common_db_arguments(restore_parser)
    restore_parser.add_argument("backup_file", help="Путь к .sql файлу бэкапа")
    restore_parser.set_defaults(func=restore_database)

    seed_parser = subparsers.add_parser(
        "seed20",
        help="Очистить заявки, сбросить ID и добавить 20 тестовых заявок",
    )
    add_common_db_arguments(seed_parser)
    seed_parser.set_defaults(func=seed_20_bookings)

    args = parser.parse_args()

    if args.password is None:
        args.password = getpass.getpass("PostgreSQL password: ")

    args.func(args)


if __name__ == "__main__":
    main()