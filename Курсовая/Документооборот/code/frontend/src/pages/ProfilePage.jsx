import { cache, useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";
 
import api from "../api/api";
 
const GROUPS = [
  "ИС-21",
  "ИС-22",
  "ИС-23",
  "ИС-24",
  "ИС-25",
];
 
const SPECIALTIES = [
  "Информационные системы и программирование",
  "Сетевое и системное администрирование",
  "Обеспечение информационной безопасности автоматизированных систем",
];
 
const COURSES = [
  1,
  2,
  3,
  4,
];
 
const EDUCATION_FORMS = [
  "очная",
  "очно-заочная",
  "заочная",
];
 
const PRACTICE_TYPES = [
  {
    value: "study",
    label: "Учебная практика",
  },
  {
    value: "production",
    label: "Производственная практика",
  },
];
 
const PRACTICE_CODES = {
  study: [
    "ПМ.12 Выполнение работ по одной или нескольким профессиям рабочих, должностям служащих",
    "УП.01 Учебная практика",
    "УП.02 Учебная практика",
  ],
  production: [
    "ПМ.12 Выполнение работ по одной или нескольким профессиям рабочих, должностям служащих",
    "ПП.01 Производственная практика",
    "ПП.02 Производственная практика",
  ],
};
 
const ORGANIZATIONS = [
  {
    name: "ГБПОУ МО «Люберецкий техникум»",
    address: "Московская область, г. Люберцы",
  },
  {
    name: "ООО «Практика»",
    address: "Московская область, г. Люберцы",
  },
];
 
const SUPERVISORS = [
  "Петров Петр Петрович",
  "Иванова Анна Сергеевна",
  "Сидоров Алексей Викторович",
];

const PROFILE_FORM_STORAGE_KEY = "practice_document_profile_form";
const DEFAULT_FORM = {
  fio: "",
  fio_genitive: "",
  study_group: GROUPS[0],
  specialty: SPECIALTIES[0],
  course: 2,
  education_form: EDUCATION_FORMS[0],
  practice_type: "study",
  practice_code: PRACTICE_CODES.study[0],
  organization: ORGANIZATIONS[0].name,
  address: ORGANIZATIONS[0].address,
  supervisor: SUPERVISORS[0],
  date_begin: "",
  date_end: "",
  document_date: "",
}

function loadSavedForm() {
  try {
    const savedForm = localStorage.getItem(PROFILE_FORM_STORAGE_KEY);
    if (!savedForm) {
      return DEFAULT_FORM;
    }
    return {
      ...DEFAULT_FORM,
      ...JSON.parse(savedForm),
    };
  }
  catch (error) {
    return DEFAULT_FORM;
  }
}
 
function ProfilePage() {
  const navigate = useNavigate();
 
  const [profile, setProfile] = useState(null);
 
  const [form, setForm] = useState(() => loadSavedForm());
 
  const [documents, setDocuments] = useState([]);
  const [loadingProfile, setLoadingProfile] = useState(true);
  const [generating, setGenerating] = useState(false);
  const [error, setError] = useState("");
 
  useEffect(() => {
    async function loadProfile() {
      const token = localStorage.getItem("access");
 
      if (!token) {
        navigate("/");
        return;
      }
 
      try {
        const response = await api.get("/accounts/profile/");
 
        setProfile(response.data);
 
        const savedForm = localStorage.getItem(PROFILE_FORM_STORAGE_KEY);
        if (!savedForm) {
          setForm((prev) => ({
            ...prev,
            fio: response.data.full_name || "",
            fio_genitive: response.data.full_name || "",
            study_group: response.data.study_group || GROUPS[0],
          }));
        }
      } catch (error) {
        localStorage.removeItem("access");
        localStorage.removeItem("refresh");
        navigate("/");
      } finally {
        setLoadingProfile(false);
      }
    }
 
    loadProfile();
  }, [navigate]);

  useEffect(() => {
    localStorage.setItem(PROFILE_FORM_STORAGE_KEY, JSON.stringify(form));
  }, [form]);
 
  function handleChange(event) {
    const { name, value } = event.target;
 
    if (name === "practice_type") {
      setForm((prev) => ({
        ...prev,
        practice_type: value,
        practice_code: PRACTICE_CODES[value][0],
      }));
 
      return;
    }
 
    if (name === "organization") {
      const selectedOrganization = ORGANIZATIONS.find((item) => item.name === value);
 
      setForm((prev) => ({
        ...prev,
        organization: value,
        address: selectedOrganization?.address || "",
      }));
 
      return;
    }
 
    setForm((prev) => ({
      ...prev,
      [name]: value,
    }));
  }
 
  async function handleSubmit(event) {
    event.preventDefault();
 
    setError("");
    setDocuments([]);
    setGenerating(true);
 
    try {
      const response = await api.post("/documents/generate/", {
        ...form,
        course: Number(form.course),
      });
 
      setDocuments(response.data.documents);
    } catch (error) {
      console.log(error.response?.data);
      if (error.response?.data?.detail) {
        setError(error.response.data.detail);
      } else if (error.response?.data) {
        setError("Ошибка создания документов. Проверь заполнение формы.");
      } else {
        setError("Backend-сервер не отвечает.");
      }
    } finally {
      setGenerating(false);
    }
  }
 
  function handleLogout() {
    localStorage.removeItem("access");
    localStorage.removeItem("refresh");
    navigate("/");
  }

  function handleResetForm() {
    const nextForm = {
      ...DEFAULT_FORM,
      fio: profile?.full_name || "",
      fio_genitive: profile?.full_name || "",
      study_group: profile?.study_group || GROUPS[0],
    }
    setForm(nextForm);
    localStorage.setItem(PROFILE_FORM_STORAGE_KEY, JSON.stringify(nextForm));
    setDocuments([]);
    setError("");
  }
 
  if (loadingProfile) {
    return (
      <main className="page">
        <p>Загрузка профиля...</p>
      </main>
    );
  }
 
  return (
    <main className="page">
      <header className="page-header">
        <div>
          <h1>Профиль</h1>
          <p>
            Пользователь: <strong>{profile?.username}</strong>
          </p>
        </div>
 
        <div className="header-actions">
          {profile?.is_admin && (
            <button type="button" className="secondary-button" onClick={() => navigate("/admin")}>
              Админ-панель
            </button>
          )}
 
          <button type="button" className="secondary-button" onClick={handleLogout}>
            Выйти
          </button>
        </div>
      </header>
 
      <section className="card">
        <h2>Данные для документов</h2>
 
        <form className="practice-form" onSubmit={handleSubmit}>
          <label>
            ФИО
            <input
              type="text"
              name="fio"
              value={form.fio}
              onChange={handleChange}
              required
            />
          </label>

          <label>
            ФИО в родительном падеже
            <input
              type="text"
              name="fio_genitive"
              value={form.fio_genitive}
              onChange={handleChange}
              required
            />
          </label>
 
          <label>
            Группа
            <select
              name="study_group"
              value={form.study_group}
              onChange={handleChange}
              required
            >
              {GROUPS.map((group) => (
                <option key={group} value={group}>
                  {group}
                </option>
              ))}
            </select>
          </label>
 
          <label>
            Специальность
            <select
              name="specialty"
              value={form.specialty}
              onChange={handleChange}
              required
            >
              {SPECIALTIES.map((specialty) => (
                <option key={specialty} value={specialty}>
                  {specialty}
                </option>
              ))}
            </select>
          </label>
 
          <label>
            Курс
            <select
              name="course"
              value={form.course}
              onChange={handleChange}
              required
            >
              {COURSES.map((course) => (
                <option key={course} value={course}>
                  {course}
                </option>
              ))}
            </select>
          </label>
 
          <label>
            Форма обучения
            <select
              name="education_form"
              value={form.education_form}
              onChange={handleChange}
              required
            >
              {EDUCATION_FORMS.map((educationForm) => (
                <option key={educationForm} value={educationForm}>
                  {educationForm}
                </option>
              ))}
            </select>
          </label>
 
          <label>
            Тип практики
            <select
              name="practice_type"
              value={form.practice_type}
              onChange={handleChange}
              required
            >
              {PRACTICE_TYPES.map((practiceType) => (
                <option key={practiceType.value} value={practiceType.value}>
                  {practiceType.label}
                </option>
              ))}
            </select>
          </label>
          <label className="wide-field">
            Профессиональный модуль / код практики
            <select
              name="practice_code"
              value={form.practice_code}
              onChange={handleChange}
              required
            >
              {PRACTICE_CODES[form.practice_type].map((practiceCode) => (
                <option key={practiceCode} value={practiceCode}>
                  {practiceCode}
                </option>
              ))}
            </select>
          </label>
 
          <label className="wide-field">
            Место практики
            <select
              name="organization"
              value={form.organization}
              onChange={handleChange}
              required
            >
              {ORGANIZATIONS.map((organization) => (
                <option key={organization.name} value={organization.name}>
                  {organization.name}
                </option>
              ))}
            </select>
          </label>
 
          <label className="wide-field">
            Адрес
            <input
              type="text"
              name="address"
              value={form.address}
              onChange={handleChange}
              required
            />
          </label>
 
          <label className="wide-field">
            Руководитель практики
            <select
              name="supervisor"
              value={form.supervisor}
              onChange={handleChange}
              required
            >
              {SUPERVISORS.map((supervisor) => (
                <option key={supervisor} value={supervisor}>
                  {supervisor}
                </option>
              ))}
            </select>
          </label>
 
          <label>
            Дата начала
            <input
              type="date"
              name="date_begin"
              value={form.date_begin}
              onChange={handleChange}
              required
            />
          </label>
 
          <label>
            Дата окончания
            <input
              type="date"
              name="date_end"
              value={form.date_end}
              onChange={handleChange}
              required
            />
          </label>
 
          <label>
            Дата документа
            <input
              type="date"
              name="document_date"
              value={form.document_date}
              onChange={handleChange}
              required
            />
          </label>
 
          {error && <p className="error-text wide-field">{error}</p>}
 
          <div className="form-buttons wide-field">
            <button type="submit" disabled={generating} className="submit-button">
              {generating ? "Создание..." : "Создать документы"}
            </button>

            <button type="button" className="secondary-button" onClick={handleResetForm}>
              Сбросить форму
            </button>
          </div>
        </form>
      </section>
 
      {documents.length > 0 && (
        <section className="card">
          <h2>Готовые документы</h2>
 
          <div className="documents-list">
            {documents.map((document) => (
              <a
                key={document.id}
                href={document.file_url}
                target="_blank"
                rel="noreferrer"
                className="document-link"
              >
                Скачать: {document.template_name}
              </a>
            ))}
          </div>
        </section>
      )}
    </main>
  );
}
 
export default ProfilePage;