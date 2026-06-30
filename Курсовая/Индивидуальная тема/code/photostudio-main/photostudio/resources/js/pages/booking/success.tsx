import { Link } from '@inertiajs/react';

export default function BookingSuccess() {
    return (
        <main className="flex min-h-screen items-center bg-neutral-950 px-6 text-white">
            <section className="mx-auto max-w-3xl text-center">
                <p className="mb-4 text-sm uppercase tracking-[0.3em] text-neutral-500">
                    Заявка отправлена
                </p>

                <h1 className="text-5xl font-semibold tracking-tight md:text-7xl">
                    Спасибо за запись
                </h1>

                <p className="mt-6 text-lg leading-8 text-neutral-300">
                    Ваша заявка сохранена. Администратор свяжется с вами, чтобы
                    подтвердить дату, время и детали съёмки.
                </p>

                <div className="mt-10 flex justify-center gap-4">
                    <Link
                        href="/"
                        className="rounded-full bg-white px-6 py-3 text-sm font-medium text-neutral-950 transition hover:bg-neutral-200"
                    >
                        На главную
                    </Link>

                    <Link
                        href="/pricing"
                        className="rounded-full border border-white/20 px-6 py-3 text-sm font-medium text-white transition hover:bg-white/10"
                    >
                        Смотреть цены
                    </Link>
                </div>
            </section>
        </main>
    );
}