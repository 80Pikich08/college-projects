from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("documents", "0004_triggerlog"),
    ]

    operations = [
        migrations.RunSQL(
            sql="""
            CREATE TRIGGER IF NOT EXISTS trg_practicedata_insert
            AFTER INSERT ON documents_practicedata
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'INSERT',
                    'documents_practicedata',
                    NEW.id,
                    'Добавлены данные практики для студента: ' || NEW.fio,
                    CURRENT_TIMESTAMP
                );
            END;
            """,
            reverse_sql="""
            DROP TRIGGER IF EXISTS trg_practicedata_insert;
            """,
        ),

        migrations.RunSQL(
            sql="""
            CREATE TRIGGER IF NOT EXISTS trg_practicedata_update
            AFTER UPDATE ON documents_practicedata
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'UPDATE',
                    'documents_practicedata',
                    NEW.id,
                    'Изменены данные практики для студента: ' || NEW.fio,
                    CURRENT_TIMESTAMP
                );
            END;
            """,
            reverse_sql="""
            DROP TRIGGER IF EXISTS trg_practicedata_update;
            """,
        ),

        migrations.RunSQL(
            sql="""
            CREATE TRIGGER IF NOT EXISTS trg_generateddocument_insert
            AFTER INSERT ON documents_generateddocument
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'INSERT',
                    'documents_generateddocument',
                    NEW.id,
                    'Создан новый документ: ' || NEW.file,
                    CURRENT_TIMESTAMP
                );
            END;
            """,
            reverse_sql="""
            DROP TRIGGER IF EXISTS trg_generateddocument_insert;
            """,
        ),

        migrations.RunSQL(
            sql="""
            CREATE TRIGGER IF NOT EXISTS trg_template_insert
            AFTER INSERT ON templates_app_documenttemplate
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'INSERT',
                    'templates_app_documenttemplate',
                    NEW.id,
                    'Загружен новый шаблон: ' || NEW.name,
                    CURRENT_TIMESTAMP
                );
            END;
            """,
            reverse_sql="""
            DROP TRIGGER IF EXISTS trg_template_insert;
            """,
        ),

        migrations.RunSQL(
            sql="""
            CREATE TRIGGER IF NOT EXISTS trg_template_update
            AFTER UPDATE ON templates_app_documenttemplate
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'UPDATE',
                    'templates_app_documenttemplate',
                    NEW.id,
                    'Изменён шаблон: ' || NEW.name,
                    CURRENT_TIMESTAMP
                );
            END;
            """,
            reverse_sql="""
            DROP TRIGGER IF EXISTS trg_template_update;
            """,
        ),

        migrations.RunSQL(
            sql="""
            CREATE TRIGGER IF NOT EXISTS trg_template_delete
            AFTER DELETE ON templates_app_documenttemplate
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'DELETE',
                    'templates_app_documenttemplate',
                    OLD.id,
                    'Удалён шаблон: ' || OLD.name,
                    CURRENT_TIMESTAMP
                );
            END;
            """,
            reverse_sql="""
            DROP TRIGGER IF EXISTS trg_template_delete;
            """,
        ),
    ]