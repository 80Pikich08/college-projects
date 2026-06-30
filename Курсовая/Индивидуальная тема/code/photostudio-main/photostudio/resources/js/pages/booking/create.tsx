import { Link, useForm } from '@inertiajs/react';
import { FormEvent } from 'react';

type Tariff = {
    id: number;
    title: string;
    price: string;
};

type Service = {
    id: number;
    title: string;
    slug: string;
    tariffs: Tariff[];
};

type BookingItemForm = {
    service_id: string;
    tariff_id: string;
};

type BookingFormData = {
    items: BookingItemForm[];
    client_name: string;
    client_phone: string;
    client_email: string;
    client_messenger: string;
    preferred_at: string;
    comment: string;
};

type BookingCreateProps = {
    services: Service[];
    selectedServiceSlug: string | null;
    selectedTariffId: string | null;
};

export default function BookingCreate({
    services,
    selectedServiceSlug,
    selectedTariffId,
}: BookingCreateProps) {
    const serviceFromSlug = services.find(
        (service) => service.slug === selectedServiceSlug,
    );

    const initialServiceId = serviceFromSlug?.id
        ? String(serviceFromSlug.id)
        : '';

    const { data, setData, post, processing, errors, transform } =
        useForm<BookingFormData>({
            items: [
                {
                    service_id: initialServiceId,
                    tariff_id: selectedTariffId ?? '',
                },
            ],
            client_name: '',
            client_phone: '',
            client_email: '',
            client_messenger: '',
            preferred_at: '',
            comment: '',
        });

    function getServiceById(serviceId: string) {
        return services.find(
            (service) => String(service.id) === String(serviceId),
        );
    }

    function getError(key: string) {
        return errors[key as keyof typeof errors] as string | undefined;
    }

    function updateItem(
        index: number,
        field: keyof BookingItemForm,
        value: string,
    ) {
        const nextItems = [...data.items];

        nextItems[index] = {
            ...nextItems[index],
            [field]: value,
        };

        if (field === 'service_id') {
            nextItems[index].tariff_id = '';
        }

        setData('items', nextItems);
    }

    function addItem() {
        setData('items', [
            ...data.items,
            {
                service_id: '',
                tariff_id: '',
            },
        ]);
    }

    function removeItem(index: number) {
        if (data.items.length === 1) {
            return;
        }

        setData(
            'items',
            data.items.filter((_, itemIndex) => itemIndex !== index),
        );
    }

    function submit(event: FormEvent) {
        event.preventDefault();

        const filteredItems = data.items.filter((item, index) => {
            if (index === 0) {
                return true;
            }

            return item.service_id.trim().length > 0;
        });

        transform((currentData) => ({
            ...currentData,
            items: filteredItems,
        }));

        post('/booking');
    }

    return (
        <main className="min-h-screen bg-neutral-950 text-white">
            <section className="mx-auto max-w-6xl px-6 py-10">
                <Link
                    href="/"
                    className="inline-flex text-sm text-neutral-400 transition hover:text-white"
                >
                    ← На главную
                </Link>
            </section>

            <section className="mx-auto max-w-6xl px-6 pb-20 pt-6">
                <p className="mb-4 text-sm uppercase tracking-[0.3em] text-neutral-500">
                    Онлайн-запись
                </p>

                <h1 className="max-w-4xl text-5xl font-semibold tracking-tight md:text-7xl">
                    Записаться на съёмку
                </h1>

                <p className="mt-6 max-w-2xl text-lg leading-8 text-neutral-300">
                    Можно выбрать одну или несколько услуг в одной заявке.
                    Администратор свяжется с вами для подтверждения деталей.
                </p>
            </section>

            <section className="border-t border-white/10 bg-neutral-900">
                <div className="mx-auto max-w-4xl px-6 py-20">
                    <form
                        onSubmit={submit}
                        className="rounded-3xl border border-white/10 bg-white/[0.03] p-6 md:p-8"
                    >
                        <div className="mb-8">
                            <h2 className="text-2xl font-semibold">
                                Услуги в заявке
                            </h2>

                            <p className="mt-2 text-sm text-neutral-400">
                                Первая услуга обязательна. Дополнительные пустые
                                строки будут проигнорированы.
                            </p>
                        </div>

                        <div className="space-y-4">
                            {data.items.map((item, index) => {
                                const currentService = getServiceById(
                                    item.service_id,
                                );

                                const serviceError = getError(
                                    `items.${index}.service_id`,
                                );

                                const tariffError = getError(
                                    `items.${index}.tariff_id`,
                                );

                                return (
                                    <div
                                        key={index}
                                        className="rounded-3xl border border-white/10 bg-neutral-950 p-5"
                                    >
                                        <div className="mb-4 flex items-center justify-between gap-4">
                                            <h3 className="font-semibold">
                                                Услуга #{index + 1}
                                            </h3>

                                            {data.items.length > 1 && (
                                                <button
                                                    type="button"
                                                    onClick={() =>
                                                        removeItem(index)
                                                    }
                                                    className="rounded-full border border-white/10 px-4 py-2 text-sm text-neutral-300 transition hover:bg-white/10 hover:text-white"
                                                >
                                                    Убрать
                                                </button>
                                            )}
                                        </div>

                                        <div className="grid gap-4 md:grid-cols-2">
                                            <div>
                                                <label className="mb-2 block text-sm text-neutral-300">
                                                    Услуга{' '}
                                                    {index === 0 ? '*' : ''}
                                                </label>

                                                <select
                                                    value={item.service_id}
                                                    onChange={(event) =>
                                                        updateItem(
                                                            index,
                                                            'service_id',
                                                            event.target.value,
                                                        )
                                                    }
                                                    className="w-full rounded-2xl border border-white/10 bg-neutral-900 px-4 py-3 text-white outline-none transition focus:border-white/40"
                                                >
                                                    <option value="">
                                                        Выберите услугу
                                                    </option>

                                                    {services.map((service) => (
                                                        <option
                                                            key={service.id}
                                                            value={service.id}
                                                        >
                                                            {service.title}
                                                        </option>
                                                    ))}
                                                </select>

                                                {serviceError && (
                                                    <p className="mt-2 text-sm text-red-400">
                                                        {serviceError}
                                                    </p>
                                                )}
                                            </div>

                                            <div>
                                                <label className="mb-2 block text-sm text-neutral-300">
                                                    Тариф
                                                </label>

                                                <select
                                                    value={item.tariff_id}
                                                    disabled={!currentService}
                                                    onChange={(event) =>
                                                        updateItem(
                                                            index,
                                                            'tariff_id',
                                                            event.target.value,
                                                        )
                                                    }
                                                    className="w-full rounded-2xl border border-white/10 bg-neutral-900 px-4 py-3 text-white outline-none transition focus:border-white/40 disabled:opacity-50"
                                                >
                                                    <option value="">
                                                        Без тарифа
                                                    </option>

                                                    {currentService?.tariffs.map(
                                                        (tariff) => (
                                                            <option
                                                                key={tariff.id}
                                                                value={tariff.id}
                                                            >
                                                                {tariff.title} —{' '}
                                                                {Number(
                                                                    tariff.price,
                                                                ).toLocaleString(
                                                                    'ru-RU',
                                                                )}{' '}
                                                                ₽
                                                            </option>
                                                        ),
                                                    )}
                                                </select>

                                                {tariffError && (
                                                    <p className="mt-2 text-sm text-red-400">
                                                        {tariffError}
                                                    </p>
                                                )}
                                            </div>
                                        </div>
                                    </div>
                                );
                            })}
                        </div>

                        <button
                            type="button"
                            onClick={addItem}
                            className="mt-5 rounded-full border border-white/20 px-5 py-3 text-sm font-medium text-white transition hover:bg-white/10"
                        >
                            + Добавить ещё услугу
                        </button>

                        <div className="mt-10 grid gap-6 md:grid-cols-2">
                            <div>
                                <label className="mb-2 block text-sm text-neutral-300">
                                    Имя *
                                </label>

                                <input
                                    type="text"
                                    value={data.client_name}
                                    onChange={(event) =>
                                        setData(
                                            'client_name',
                                            event.target.value,
                                        )
                                    }
                                    className="w-full rounded-2xl border border-white/10 bg-neutral-950 px-4 py-3 text-white outline-none transition focus:border-white/40"
                                    placeholder="Егор"
                                />

                                {errors.client_name && (
                                    <p className="mt-2 text-sm text-red-400">
                                        {errors.client_name}
                                    </p>
                                )}
                            </div>

                            <div>
                                <label className="mb-2 block text-sm text-neutral-300">
                                    Телефон *
                                </label>

                                <input
                                    type="text"
                                    value={data.client_phone}
                                    onChange={(event) =>
                                        setData(
                                            'client_phone',
                                            event.target.value,
                                        )
                                    }
                                    className="w-full rounded-2xl border border-white/10 bg-neutral-950 px-4 py-3 text-white outline-none transition focus:border-white/40"
                                    placeholder="+7 999 999-99-99"
                                />

                                {errors.client_phone && (
                                    <p className="mt-2 text-sm text-red-400">
                                        {errors.client_phone}
                                    </p>
                                )}
                            </div>

                            <div>
                                <label className="mb-2 block text-sm text-neutral-300">
                                    Email
                                </label>

                                <input
                                    type="email"
                                    value={data.client_email}
                                    onChange={(event) =>
                                        setData(
                                            'client_email',
                                            event.target.value,
                                        )
                                    }
                                    className="w-full rounded-2xl border border-white/10 bg-neutral-950 px-4 py-3 text-white outline-none transition focus:border-white/40"
                                    placeholder="client@example.com"
                                />

                                {errors.client_email && (
                                    <p className="mt-2 text-sm text-red-400">
                                        {errors.client_email}
                                    </p>
                                )}
                            </div>

                            <div>
                                <label className="mb-2 block text-sm text-neutral-300">
                                    Telegram / WhatsApp
                                </label>

                                <input
                                    type="text"
                                    value={data.client_messenger}
                                    onChange={(event) =>
                                        setData(
                                            'client_messenger',
                                            event.target.value,
                                        )
                                    }
                                    className="w-full rounded-2xl border border-white/10 bg-neutral-950 px-4 py-3 text-white outline-none transition focus:border-white/40"
                                    placeholder="@username или номер"
                                />

                                {errors.client_messenger && (
                                    <p className="mt-2 text-sm text-red-400">
                                        {errors.client_messenger}
                                    </p>
                                )}
                            </div>

                            <div className="md:col-span-2">
                                <label className="mb-2 block text-sm text-neutral-300">
                                    Желаемая дата и время
                                </label>

                                <input
                                    type="datetime-local"
                                    value={data.preferred_at}
                                    onChange={(event) =>
                                        setData(
                                            'preferred_at',
                                            event.target.value,
                                        )
                                    }
                                    className="w-full rounded-2xl border border-white/10 bg-neutral-950 px-4 py-3 text-white outline-none transition focus:border-white/40"
                                />

                                {errors.preferred_at && (
                                    <p className="mt-2 text-sm text-red-400">
                                        {errors.preferred_at}
                                    </p>
                                )}
                            </div>

                            <div className="md:col-span-2">
                                <label className="mb-2 block text-sm text-neutral-300">
                                    Комментарий
                                </label>

                                <textarea
                                    value={data.comment}
                                    onChange={(event) =>
                                        setData('comment', event.target.value)
                                    }
                                    rows={5}
                                    className="w-full resize-none rounded-2xl border border-white/10 bg-neutral-950 px-4 py-3 text-white outline-none transition focus:border-white/40"
                                    placeholder="Например: нужна съёмка для маркетплейса, 2 образа, белый фон."
                                />

                                {errors.comment && (
                                    <p className="mt-2 text-sm text-red-400">
                                        {errors.comment}
                                    </p>
                                )}
                            </div>
                        </div>

                        <button
                            type="submit"
                            disabled={processing}
                            className="mt-8 inline-flex w-full justify-center rounded-full bg-white px-6 py-3 text-sm font-medium text-neutral-950 transition hover:bg-neutral-200 disabled:cursor-not-allowed disabled:opacity-60"
                        >
                            {processing ? 'Отправляем...' : 'Отправить заявку'}
                        </button>
                    </form>
                </div>
            </section>
        </main>
    );
}