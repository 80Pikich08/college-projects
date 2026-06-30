import { Link } from '@inertiajs/react';
import { useMemo, useState, useEffect } from 'react';

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
    tariffs: Tariff[];
};

type PricingProps = {
    services: Service[];
};

type SortMode = 'default' | 'price_asc' | 'price_desc';

export default function Pricing({ services }: PricingProps) {
    const [search, setSearch] = useState(() => {
     if (typeof window === 'undefined') {
        return '';
     }

     return localStorage.getItem('pricing_search') ?? '';
    });
    const [serviceFilter, setServiceFilter] = useState('');
    const [sortMode, setSortMode] = useState<SortMode>('default');
    useEffect(() => {
     localStorage.setItem('pricing_search', search);
    }, [search]);
 
    const filteredServices = useMemo(() => {
        const searchValue = search.trim().toLowerCase();

        return services
            .filter((service) => {
                if (!serviceFilter) {
                    return true;
                }

                return String(service.id) === serviceFilter;
            })
            .map((service) => {
                let tariffs = service.tariffs.filter((tariff) => {
                    if (!searchValue) {
                        return true;
                    }

                    const haystack = [
                        service.title,
                        service.short_description ?? '',
                        tariff.title,
                        tariff.description ?? '',
                        tariff.features ?? '',
                    ]
                        .join(' ')
                        .toLowerCase();

                    return haystack.includes(searchValue);
                });

                if (sortMode === 'price_asc') {
                    tariffs = [...tariffs].sort(
                        (a, b) => Number(a.price) - Number(b.price),
                    );
                }

                if (sortMode === 'price_desc') {
                    tariffs = [...tariffs].sort(
                        (a, b) => Number(b.price) - Number(a.price),
                    );
                }

                return {
                    ...service,
                    tariffs,
                };
            })
            .filter((service) => {
                if (searchValue) {
                    return service.tariffs.length > 0;
                }

                return true;
            });
    }, [services, search, serviceFilter, sortMode]);

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

            <section className="mx-auto max-w-6xl px-6 pb-16 pt-6">
                <p className="mb-4 text-sm uppercase tracking-[0.3em] text-neutral-500">
                    Стоимость
                </p>

                <h1 className="max-w-4xl text-5xl font-semibold tracking-tight md:text-7xl">
                    Цены на съёмку
                </h1>

                <p className="mt-6 max-w-2xl text-lg leading-8 text-neutral-300">
                    Выберите подходящую услугу и тариф. Стоимость можно быстро
                    отфильтровать по услуге, названию и цене.
                </p>
            </section>

            <section className="border-t border-white/10 bg-neutral-900">
                <div className="mx-auto max-w-6xl px-6 py-10">
                    <div className="grid gap-4 rounded-3xl border border-white/10 bg-white/[0.03] p-5 md:grid-cols-3">
                        <div>
                            <label className="mb-2 block text-sm text-neutral-300">
                                Поиск
                            </label>

                            <input
                                 type="text"
                                 value={search}
                                 onChange={(event) => setSearch(event.target.value)}
                                 placeholder="Например: портрет, видео, ретушь"
                                 className="w-full rounded-2xl border border-white/10 bg-neutral-950 px-4 py-3 text-white outline-none transition placeholder:text-neutral-600 focus:border-white/40"
                            />
                        </div>

                        <div>
                            <label className="mb-2 block text-sm text-neutral-300">
                                Услуга
                            </label>

                            <select
                                value={serviceFilter}
                                onChange={(event) =>
                                    setServiceFilter(event.target.value)
                                }
                                className="w-full rounded-2xl border border-white/10 bg-neutral-950 px-4 py-3 text-white outline-none transition focus:border-white/40"
                            >
                                <option value="">Все услуги</option>

                                {services.map((service) => (
                                    <option key={service.id} value={service.id}>
                                        {service.title}
                                    </option>
                                ))}
                            </select>
                        </div>

                        <div>
                            <label className="mb-2 block text-sm text-neutral-300">
                                Сортировка
                            </label>

                            <select
                                value={sortMode}
                                onChange={(event) =>
                                    setSortMode(event.target.value as SortMode)
                                }
                                className="w-full rounded-2xl border border-white/10 bg-neutral-950 px-4 py-3 text-white outline-none transition focus:border-white/40"
                            >
                                <option value="default">По умолчанию</option>
                                <option value="price_asc">Сначала дешевле</option>
                                <option value="price_desc">Сначала дороже</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div className="mx-auto max-w-6xl px-6 pb-20">
                    {filteredServices.length > 0 ? (
                        <div className="space-y-16">
                            {filteredServices.map((service) => (
                                <section key={service.id}>
                                    <div className="mb-8 flex flex-col gap-4 md:flex-row md:items-end md:justify-between">
                                        <div>
                                            <h2 className="text-3xl font-semibold">
                                                {service.title}
                                            </h2>

                                            {service.short_description && (
                                                <p className="mt-3 max-w-2xl text-sm leading-6 text-neutral-400">
                                                    {service.short_description}
                                                </p>
                                            )}
                                        </div>

                                        <Link
                                            href={'/services/' + service.slug}
                                            className="text-sm font-medium text-white underline underline-offset-4"
                                        >
                                            Подробнее об услуге
                                        </Link>
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
                                                            {Number(
                                                                tariff.price,
                                                            ).toLocaleString(
                                                                'ru-RU',
                                                            )}{' '}
                                                            ₽
                                                        </div>

                                                        {tariff.old_price && (
                                                            <div className="pb-1 text-sm text-neutral-500 line-through">
                                                                {Number(
                                                                    tariff.old_price,
                                                                ).toLocaleString(
                                                                    'ru-RU',
                                                                )}{' '}
                                                                ₽
                                                            </div>
                                                        )}
                                                    </div>

                                                    <div className="mt-4 flex flex-wrap gap-2 text-sm text-neutral-400">
                                                        {tariff.duration_minutes && (
                                                            <span className="rounded-full border border-white/10 px-3 py-1">
                                                                {
                                                                    tariff.duration_minutes
                                                                }{' '}
                                                                мин.
                                                            </span>
                                                        )}

                                                        {tariff.photos_count && (
                                                            <span className="rounded-full border border-white/10 px-3 py-1">
                                                                {tariff.photos_count}{' '}
                                                                фото
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
                                                                .filter(
                                                                    (feature) =>
                                                                        feature
                                                                            .trim()
                                                                            .length > 0,
                                                                )
                                                                .map((feature) => (
                                                                    <li
                                                                        key={feature}
                                                                        className="flex gap-3"
                                                                    >
                                                                        <span className="mt-2 h-1.5 w-1.5 shrink-0 rounded-full bg-white" />
                                                                        <span>
                                                                            {feature.replace(
                                                                                /^-\s*/,
                                                                                '',
                                                                            )}
                                                                        </span>
                                                                    </li>
                                                                ))}
                                                        </ul>
                                                    )}

                                                    <Link
                                                        href={
                                                            '/booking?service=' +
                                                            service.slug +
                                                            '&tariff=' +
                                                            tariff.id
                                                        }
                                                        className="mt-8 inline-flex w-full justify-center rounded-full bg-white px-6 py-3 text-sm font-medium text-neutral-950 transition hover:bg-neutral-200"
                                                    >
                                                        Выбрать тариф
                                                    </Link>
                                                </article>
                                            ))}
                                        </div>
                                    ) : (
                                        <div className="rounded-3xl border border-dashed border-white/20 p-8 text-neutral-400">
                                            По выбранным условиям тарифы не найдены.
                                        </div>
                                    )}
                                </section>
                            ))}
                        </div>
                    ) : (
                        <div className="rounded-3xl border border-dashed border-white/20 p-8 text-neutral-400">
                            Ничего не найдено. Попробуйте изменить поиск или фильтр.
                        </div>
                    )}
                </div>
            </section>
        </main>
    );
}