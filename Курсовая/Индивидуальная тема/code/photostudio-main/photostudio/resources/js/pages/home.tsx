import { Link } from "@inertiajs/react";

type Service = {
  id: number;
  title: string;
  slug: string;
  short_description: string | null;
  description: string | null;
  cover_image: string | null;
};

type HomeProps = {
  services: Service[];
};

export default function Home({ services }: HomeProps) {
  return (
    <main className="min-h-screen bg-neutral-950 text-white">
      <section className="mx-auto flex min-h-[70vh] max-w-6xl flex-col justify-center px-6 py-20">
        <img
           src="/images/logo.png"
           alt="Логотип фотостудии"
           className="mb-8 h-16 w-auto object-contain"
        />
        <p className="mb-4 text-sm uppercase tracking-[0.3em] text-neutral-400">
          Фотостудия
        </p>

        <h1 className="max-w-3xl text-5xl font-semibold tracking-tight md:text-7xl">
          Профессиональная съёмка для людей, брендов и товаров
        </h1>

        <p className="mt-6 max-w-2xl text-lg leading-8 text-neutral-300">
          Студийные фотосессии, предметная съёмка, портфолио, контент для
          маркетплейсов и визуал для личного бренда.
        </p>

        <div className="mt-10 flex flex-wrap gap-4">
          <a
            href="#booking"
            className="rounded-full bg-white px-6 py-3 text-sm font-medium text-neutral-950 transition hover:bg-neutral-200"
          >
            Записаться на съёмку
          </a>

          <a
            href="#services"
            className="rounded-full border border-white/20 px-6 py-3 text-sm font-medium text-white transition hover:bg-white/10"
          >
            Смотреть услуги
          </a>

          <Link
            href="/pricing"
            className="rounded-full border border-white/20 px-6 py-3 text-sm font-medium text-white transition hover:bg-white/10"
          >
            Цены
          </Link>

          <Link
           href="/about"
           className="rounded-full border border-white/20 px-6 py-3 text-sm font-medium text-white transition hover:bg-white/10"
          >
           О нас
         </Link>

        </div>
      </section>

      <section
        id="services"
        className="border-t border-white/10 bg-neutral-900"
      >
        <div className="mx-auto max-w-6xl px-6 py-20">
          <div className="mb-10">
            <p className="mb-3 text-sm uppercase tracking-[0.3em] text-neutral-500">
              Услуги
            </p>

            <h2 className="text-3xl font-semibold md:text-4xl">
              Что можно заказать
            </h2>
          </div>

          {services.length > 0 ? (
            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
              {services.map((service) => (
                <article
                  key={service.id}
                  className="rounded-3xl border border-white/10 bg-white/[0.03] p-6 transition hover:border-white/30 hover:bg-white/[0.06]"
                >
                  <div className="mb-6 flex h-12 w-12 items-center justify-center rounded-2xl bg-white text-lg font-semibold text-neutral-950">
                    {service.title.slice(0, 1)}
                  </div>

                  <h3 className="text-xl font-semibold">{service.title}</h3>

                  {service.short_description && (
                    <p className="mt-3 text-sm leading-6 text-neutral-300">
                      {service.short_description}
                    </p>
                  )}

                  <Link
                    href={"/services/" + service.slug}
                    className="mt-6 inline-flex text-sm font-medium text-white underline underline-offset-4"
                  >
                    Подробнее
                  </Link>
                </article>
              ))}
            </div>
          ) : (
            <div className="rounded-3xl border border-dashed border-white/20 p-8 text-neutral-400">
              Услуги пока не добавлены. Добавьте их в Filament-админке.
            </div>
          )}
        </div>
      </section>

      <section id="booking" className="bg-neutral-950">
        <div className="mx-auto max-w-6xl px-6 py-20">
          <div className="rounded-3xl bg-white p-8 text-neutral-950 md:p-12">
            <h2 className="text-3xl font-semibold">
              Хотите записаться на съёмку?
            </h2>

            <p className="mt-4 max-w-2xl text-neutral-600">
              Скоро здесь будет полноценная форма онлайн-записи. Пока можно
              оставить этот блок как точку перехода к будущей заявке.
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