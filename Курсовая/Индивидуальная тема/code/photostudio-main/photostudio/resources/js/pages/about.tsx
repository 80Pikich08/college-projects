import { Head, Link } from '@inertiajs/react';
 
export default function About() {
    return (
        <main className="min-h-screen bg-neutral-950 text-white">
            <Head title="О нас" />
 
            <section className="mx-auto max-w-6xl px-6 py-10">
                <div className="flex flex-wrap items-center justify-between gap-4">
                    <Link
                        href="/"
                        className="text-sm text-neutral-400 transition hover:text-white"
                    >
                        ← На главную
                    </Link>
 
                    <nav className="flex flex-wrap gap-4 text-sm text-neutral-400">
                        <Link href="/pricing" className="transition hover:text-white">
                            Цены
                        </Link>
 
                        <Link href="/booking" className="transition hover:text-white">
                            Запись
                        </Link>
                    </nav>
                </div>
            </section>
 
            <section className="mx-auto grid max-w-6xl gap-10 px-6 pb-20 pt-6 lg:grid-cols-[1.1fr_0.9fr] lg:items-center">
                <div>
                    <p className="mb-4 text-sm uppercase tracking-[0.3em] text-neutral-500">
                        О фотостудии
                    </p>
 
                    <h1 className="max-w-4xl text-5xl font-semibold tracking-tight md:text-7xl">
                        Создаём визуал, который помогает людям и брендам выглядеть сильнее
                    </h1>
 
                    <p className="mt-6 max-w-2xl text-lg leading-8 text-neutral-300">
                        Наша фотостудия занимается портретной, имиджевой, предметной
                        и коммерческой съёмкой. Мы помогаем подготовить визуальный
                        контент для личного бренда, социальных сетей, маркетплейсов,
                        сайтов и каталогов.
                    </p>
 
                    <div className="mt-10 flex flex-wrap gap-4">
                        <Link
                            href="/booking"
                            className="rounded-full bg-white px-6 py-3 text-sm font-medium text-neutral-950 transition hover:bg-neutral-200"
                        >
                            Записаться на съёмку
                        </Link>
 
                        <Link
                            href="/pricing"
                            className="rounded-full border border-white/20 px-6 py-3 text-sm font-medium text-white transition hover:bg-white/10"
                        >
                            Смотреть цены
                        </Link>
                    </div>
                </div>
 
                <div className="rounded-[2rem] border border-white/10 bg-white/[0.03] p-6">
                    <div className="flex h-[420px] items-center justify-center rounded-[1.5rem] bg-neutral-900">
                        <div className="text-center">
                            <div className="mx-auto flex h-28 w-28 items-center justify-center rounded-3xl bg-white text-5xl font-semibold text-neutral-950">
                                FS
                            </div>
 
                            <p className="mt-6 text-sm uppercase tracking-[0.3em] text-neutral-500">
                                Photo Studio
                            </p>
                        </div>
                    </div>
                </div>
            </section>
 
            <section className="border-t border-white/10 bg-neutral-900">
                <div className="mx-auto max-w-6xl px-6 py-20">
                    <div className="mb-10">
                        <p className="mb-3 text-sm uppercase tracking-[0.3em] text-neutral-500">
                            Подход
                        </p>
 
                        <h2 className="text-3xl font-semibold md:text-4xl">
                            Как мы работаем
                        </h2>
                    </div>
                     <div className="grid gap-6 md:grid-cols-3">
                        <article className="rounded-3xl border border-white/10 bg-white/[0.03] p-6">
                            <div className="mb-6 flex h-12 w-12 items-center justify-center rounded-2xl bg-white text-lg font-semibold text-neutral-950">
                                1
                            </div>
 
                            <h3 className="text-xl font-semibold">
                                Разбираем задачу
                            </h3>
 
                            <p className="mt-3 text-sm leading-6 text-neutral-300">
                                Перед съёмкой уточняем цель: личный бренд, портфолио,
                                карточка товара, каталог, соцсети или рекламный визуал.
                            </p>
                        </article>
 
                        <article className="rounded-3xl border border-white/10 bg-white/[0.03] p-6">
                            <div className="mb-6 flex h-12 w-12 items-center justify-center rounded-2xl bg-white text-lg font-semibold text-neutral-950">
                                2
                            </div>
 
                            <h3 className="text-xl font-semibold">
                                Подбираем формат
                            </h3>
 
                            <p className="mt-3 text-sm leading-6 text-neutral-300">
                                Помогаем выбрать услугу, тариф, количество образов,
                                фон, свет, длительность и нужный объём обработки.
                            </p>
                        </article>
 
                        <article className="rounded-3xl border border-white/10 bg-white/[0.03] p-6">
                            <div className="mb-6 flex h-12 w-12 items-center justify-center rounded-2xl bg-white text-lg font-semibold text-neutral-950">
                                3
                            </div>
 
                            <h3 className="text-xl font-semibold">
                                Доводим до результата
                            </h3>
 
                            <p className="mt-3 text-sm leading-6 text-neutral-300">
                                Проводим съёмку, отбираем кадры, выполняем обработку
                                и передаём готовые материалы в удобном формате.
                            </p>
                        </article>
                    </div>
                </div>
            </section>
 
            <section className="border-t border-white/10 bg-neutral-950">
                <div className="mx-auto grid max-w-6xl gap-10 px-6 py-20 lg:grid-cols-[0.8fr_1.2fr]">
                    <div>
                        <p className="mb-3 text-sm uppercase tracking-[0.3em] text-neutral-500">
                            Преимущества
                        </p>
 
                        <h2 className="text-3xl font-semibold md:text-4xl">
                            Почему с нами удобно
                        </h2>
                    </div>
 
                    <div className="grid gap-4 md:grid-cols-2">
                        <div className="rounded-3xl border border-white/10 bg-white/[0.03] p-6">
                            <h3 className="font-semibold">
                                Понятные тарифы
                            </h3>
 
                            <p className="mt-3 text-sm leading-6 text-neutral-300">
                                Услуги разделены по форматам, чтобы клиент сразу
                                понимал примерную стоимость и состав съёмки.
                            </p>
                        </div>
 
                        <div className="rounded-3xl border border-white/10 bg-white/[0.03] p-6">
                            <h3 className="font-semibold">
                                Онлайн-запись
                            </h3>
                            <p className="mt-3 text-sm leading-6 text-neutral-300">
                                Можно оставить заявку на сайте, выбрать услугу,
                                тариф и желаемое время.
                            </p>
                        </div>
 
                        <div className="rounded-3xl border border-white/10 bg-white/[0.03] p-6">
                            <h3 className="font-semibold">
                                Индивидуальный подход
                            </h3>
 
                            <p className="mt-3 text-sm leading-6 text-neutral-300">
                                Для разных задач подбираем разный свет, фон,
                                композицию и стиль обработки.
                            </p>
                        </div>
 
                        <div className="rounded-3xl border border-white/10 bg-white/[0.03] p-6">
                            <h3 className="font-semibold">
                                Коммерческий результат
                            </h3>
 
                            <p className="mt-3 text-sm leading-6 text-neutral-300">
                                Делаем не просто красивые фотографии, а визуал,
                                который можно использовать в продажах, профиле,
                                каталоге или рекламе.
                            </p>
                        </div>
                    </div>
                </div>
            </section>
 
            <section className="bg-neutral-900">
                <div className="mx-auto max-w-6xl px-6 py-20">
                    <div className="rounded-3xl bg-white p-8 text-neutral-950 md:p-12">
                        <p className="mb-3 text-sm uppercase tracking-[0.3em] text-neutral-500">
                            Запись
                        </p>
 
                        <h2 className="text-3xl font-semibold">
                            Готовы обсудить съёмку?
                        </h2>
 
                        <p className="mt-4 max-w-2xl text-neutral-600">
                            Оставьте заявку, и администратор свяжется с вами,
                            чтобы уточнить задачу, формат, дату и стоимость.
                        </p>
 
                        <Link
                            href="/booking"
                            className="mt-8 inline-flex rounded-full bg-neutral-950 px-6 py-3 text-sm font-medium text-white transition hover:bg-neutral-800"
                        >
                            Записаться
                        </Link>
                    </div>
                </div>
            </section>
        </main>
    );
}