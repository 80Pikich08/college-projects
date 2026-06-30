import { Link } from '@inertiajs/react';
 
type Tariff = {
    id: number;
    title: string;
    price: string;
    old_price: string | null;
    duration_minutes: number | null;
    photos_count: number | null;
    description: string | null;
    features: string | null;
    is_popular: boolean;
};
 
type Service = {
    id: number;
    title: string;
    slug: string;
    short_description: string | null;
    description: string | null;
    cover_image: string | null;
    tariffs: Tariff[];
};
 
type ServiceShowProps = {
    service: Service;
};
export default function ServiceShow({ service }: ServiceShowProps) {
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
            <section className="mx-auto grid max-w-6xl gap-10 px-6 pb-20 pt-6 lg:grid-cols-[1.1fr_0.9fr] lg:items-center">
                <div>
                    <p className="mb-4 text-sm uppercase tracking-[0.3em] text-neutral-500">
                        Услуга фотостудии
                    </p>
                    <h1 className="text-5xl font-semibold tracking-tight md:text-7xl">
                        {service.title}
                    </h1>
                    {service.short_description && (
                        <p className="mt-6 max-w-2xl text-lg leading-8 text-neutral-300">
                            {service.short_description}
                        </p>
                    )}
                    <div className="mt-10 flex flex-wrap gap-4">
                        <Link
                                 href={'/booking'}
                                 className="rounded-full bg-white px-6 py-3 text-sm font-medium text-neutral-950 transition hover:bg-neutral-200"
                        >
                                Записаться
                        </Link>
                        <Link
                            href="/"
                            className="rounded-full border border-white/20 px-6 py-3 text-sm font-medium text-white transition hover:bg-white/10"
                        >
                            Все услуги
                        </Link>
                    </div>
                </div>
                <div className="overflow-hidden rounded-[2rem] border border-white/10 bg-white/[0.03]">
                    {service.cover_image ? (
                        <img
                            src={`/storage/${service.cover_image}`}
                            alt={service.title}
                            className="h-[420px] w-full object-cover"
                        />
                    ) : (
                        <div className="flex h-[420px] items-center justify-center bg-neutral-900">
                            <div className="flex h-28 w-28 items-center justify-center rounded-3xl bg-white text-5xl font-semibold text-neutral-950">
                                {service.title.slice(0, 1)}
                            </div>
                        </div>
                    )}
                </div>
            </section>
            <section className="border-t border-white/10 bg-neutral-900">
                <div className="mx-auto grid max-w-6xl gap-10 px-6 py-20 lg:grid-cols-[0.8fr_1.2fr]">
                    <div>
                        <p className="mb-3 text-sm uppercase tracking-[0.3em] text-neutral-500">
                            Описание
                        </p>
                        <h2 className="text-3xl font-semibold">
                            Что входит в съёмку
                        </h2>
                    </div>
                    <div className="rounded-3xl border border-white/10 bg-white/[0.03] p-8">
                        {service.description ? (

                            <div className="space-y-4 whitespace-pre-line text-base leading-8 text-neutral-300">
                                {service.description}
                            </div>
                        ) : (
                            <p className="text-neutral-400">
                                Подробное описание пока не добавлено. Его можно
                                заполнить в Filament-админке.
                            </p>
                        )}
                    </div>
                </div>
            </section>
            <section className="border-t border-white/10 bg-neutral-950">
                <div className="mx-auto max-w-6xl px-6 py-20">
                    <div className="mb-10">
                        <p className="mb-3 text-sm uppercase tracking-[0.3em] text-neutral-500">
                            Цены
                        </p>
 
                        <h2 className="text-3xl font-semibold md:text-4xl">
                            Тарифы на съёмку
                        </h2>
                    </div>
 
                    {service.tariffs.length > 0 ? (
                        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
                            {service.tariffs.map((tariff) => (
                                <article
                                    key={tariff.id}
                                    className="relative rounded-3xl border border-white/10 bg-white/[0.03] p-6"
                                >
                                    {tariff.is_popular && (
                                        <div className="absolute right-5 top-5 rounded-full bg-white px-3 py-1 text-xs font-medium text-neutral-950">
                                            Популярный
                                        </div>
                                    )}
 
                                    <h3 className="pr-28 text-2xl font-semibold">
                                        {tariff.title}
                                    </h3>
 
                                    <div className="mt-6 flex items-end gap-3">
                                        <div className="text-4xl font-semibold">
                                            {Number(tariff.price).toLocaleString('ru-RU')} ₽
                                        </div>
 
                                        {tariff.old_price && (
                                            <div className="pb-1 text-sm text-neutral-500 line-through">
                                                {Number(tariff.old_price).toLocaleString('ru-RU')} ₽
                                            </div>
                                        )}
                                    </div>
 
                                    <div className="mt-4 flex flex-wrap gap-2 text-sm text-neutral-400">
                                        {tariff.duration_minutes && (
                                            <span className="rounded-full border border-white/10 px-3 py-1">
                                                {tariff.duration_minutes} мин.
                                            </span>
                                        )}
 
                                        {tariff.photos_count && (
                                            <span className="rounded-full border border-white/10 px-3 py-1">
                                                {tariff.photos_count} фото
                                            </span>
                                        )}
                                    </div>
 
                                    {tariff.description && (
                                        <p className="mt-5 text-sm leading-6 text-neutral-300">
                                            {tariff.description}
                                        </p>
                                    )}

                                    {tariff.features && (
                                        <ul className="mt-6 space-y-3 text-sm text-neutral-300">
                                            {tariff.features
                                                .split('\n')
                                                .filter((feature) => feature.trim().length > 0)
                                                .map((feature) => (
                                                    <li key={feature} className="flex gap-3">
                                                        <span className="mt-2 h-1.5 w-1.5 shrink-0 rounded-full bg-white" />
                                                        <span>{feature.replace(/^-\s*/, '')}</span>
                                                    </li>
                                                ))}
                                        </ul>
                                    )}
 
                                    <Link
                                          href={'/booking?service=' + service.slug}
                                          className="rounded-full bg-white px-6 py-3 text-sm font-medium text-neutral-950 transition hover:bg-neutral-200"
                                    >
                                        Записаться
                                    </Link>
                                </article>
                            ))}
                        </div>
                    ) : (
                        <div className="rounded-3xl border border-dashed border-white/20 p-8 text-neutral-400">
                            Тарифы для этой услуги пока не добавлены.
                        </div>
                    )}
                </div>
            </section>
            <section id="booking" className="bg-neutral-950">
                <div className="mx-auto max-w-6xl px-6 py-20">
                    <div className="rounded-3xl bg-white p-8 text-neutral-950 md:p-12">
                        <p className="mb-3 text-sm uppercase tracking-[0.3em] text-neutral-500">
                            Запись
                        </p>
                        <h2 className="text-3xl font-semibold">
                            Записаться на услугу: {service.title}
                        </h2>
                        <p className="mt-4 max-w-2xl text-neutral-600">
                            Позже здесь будет форма онлайн-записи. Пока можно
                            оставить кнопку связи или сделать простую заявку.
                        </p>
                        <a
                            href="tel:+79999999999"
                            className="mt-8 inline-flex rounded-full bg-neutral-950 px-6 py-3 text-sm font-medium text-white transition hover:bg-neutral-800"
                        >
                            Позвонить
                        </a>
                    </div>
                </div>
            </section>
        </main>
    );
}