import os
import uuid

from django.conf import settings
from docxtpl import DocxTemplate


MONTHS_RU = {
    1: "января",
    2: "февраля",
    3: "марта",
    4: "апреля",
    5: "мая",
    6: "июня",
    7: "июля",
    8: "августа",
    9: "сентября",
    10: "октября",
    11: "ноября",
    12: "декабря",
}


def FormatDay(value):
    return str(value.day)


def FormatMonthRu(value):
    return MONTHS_RU[value.month]


def FormatYear(value):
    return str(value.year)


def FormatFullDateRu(value):
    return f"{value.day} {MONTHS_RU[value.month]} {value.year}"


def BuildContext(practice_data):
    practice_days = (practice_data.date_end - practice_data.date_begin).days + 1
    fio_genitive = practice_data.fio_genitive or practice_data.fio
    return {
        # Основные поля
        "fio": practice_data.fio,
        "fio_genitive": fio_genitive,

        # Специальность
        "spec": practice_data.specialty,
        "special": practice_data.specialty,
        "specialty": practice_data.specialty,

        # Группа / курс / форма обучения
        "grupa": practice_data.study_group,
        "group": practice_data.study_group,
        "study_group": practice_data.study_group,
        "kurs": practice_data.course,
        "course": practice_data.course,
        "obuch": practice_data.education_form,
        "education_form": practice_data.education_form,

        # Практика
        "vid": practice_data.get_practice_type_display().split()[0][:-3].lower(),
        "practice_type": practice_data.get_practice_type_display(),
        "kod": practice_data.practice_code,
        "practice_code": practice_data.practice_code,

        # Место практики
        "mesto": practice_data.organization,
        "library": practice_data.organization,
        "organization": practice_data.organization,
        "adress": practice_data.address,
        "address": practice_data.address,

        # Руководитель
        "ruka": practice_data.supervisor,
        "boss_organization": practice_data.supervisor,
        "supervisor": practice_data.supervisor,

        # Даты для шаблонов УП / ПП
        "data": FormatDay(practice_data.date_begin),
        "data2": FormatMonthRu(practice_data.date_begin),
        "god": FormatYear(practice_data.date_begin),

        "data3": FormatDay(practice_data.date_end),
        "data4": FormatMonthRu(practice_data.date_end),
        "god1": FormatYear(practice_data.date_end),

        # Даты для шаблона "характеристика ПП"
        "month_begin": FormatDay(practice_data.date_begin),
        "day_begin": f" {FormatMonthRu(practice_data.date_begin)} ",
        "year_begin": FormatYear(practice_data.date_begin),

        "month_finish": FormatDay(practice_data.date_end),
        "day_finish": f" {FormatMonthRu(practice_data.date_end)} ",
        "year_finish": FormatYear(practice_data.date_end),

        # Количество дней и характеристика
        "number": practice_days,
        "not_day_one": 0,
        "not_day_two": 0,
        "good": "отличное",

        # Плюсы в таблицах
        "da": "+",
    }


def EnsureGeneratedDir():
    generated_dir = os.path.join(settings.MEDIA_ROOT, "generated")
    os.makedirs(generated_dir, exist_ok=True)

    return generated_dir


def GenerateDocx(template, practice_data):
    context = BuildContext(practice_data)
    generated_dir = EnsureGeneratedDir()

    filename = f"document_{practice_data.user.id}_{uuid.uuid4().hex}.docx"
    output_path = os.path.join(generated_dir, filename)

    document = DocxTemplate(template.file.path)
    document.render(context)
    document.save(output_path)

    return f"generated/{filename}"