import { useState } from "react";
import { useNavigate } from "react-router-dom";

import api from "../api/api";

function HomePage() {
  const navigate = useNavigate();

  const [loginForm, setLoginForm] = useState({
    username: "",
    password: "",
  });

  const [registerForm, setRegisterForm] = useState({
    username: "",
    password: "",
    full_name: "",
    fio_genitive: "",
    study_group: "",
  });

  const [loginError, setLoginError] = useState("");
  const [registerError, setRegisterError] = useState("");
  const [loading, setLoading] = useState(false);

  function handleLoginChange(event) {
    const { name, value } = event.target;

    setLoginForm((prev) => ({
      ...prev,
      [name]: value,
    }));
  }

  function handleRegisterChange(event) {
    const { name, value } = event.target;

    setRegisterForm((prev) => ({
      ...prev,
      [name]: value,
    }));
  }

  async function loginUser(username, password) {
    const response = await api.post("/accounts/login/", {
      username,
      password,
    });

    localStorage.setItem("access", response.data.access);
    localStorage.setItem("refresh", response.data.refresh);
  }

  async function handleLoginSubmit(event) {
    event.preventDefault();

    setLoginError("");
    setLoading(true);

    try {
      await loginUser(loginForm.username, loginForm.password);
      localStorage.setItem(
        "practice_document_profile_form",
        JSON.stringify({
          fio: registerForm.full_name,
          fio_genitive: registerForm.fio_genitive || registerForm.full_name,
          study_group: registerForm.study_group,
        })
      );
      navigate("/profile");
    } catch (error) {
      setLoginError("Неверный логин или пароль.");
    } finally {
      setLoading(false);
    }
  }

  async function handleRegisterSubmit(event) {
    event.preventDefault();

    setRegisterError("");
    setLoading(true);

    try {
      await api.post("/accounts/register/", {
        username: registerForm.username,
        password: registerForm.password,
        full_name: registerForm.full_name,
        study_group: registerForm.study_group,
      });

      await loginUser(registerForm.username, registerForm.password);

      navigate("/profile");
    } catch (error) {
      if (error.response?.data?.username) {
        setRegisterError("Пользователь с таким логином уже существует.");
      } else if (error.response?.data?.password) {
        setRegisterError("Пароль слишком короткий или некорректный.");
      } else {
        setRegisterError("Ошибка регистрации. Проверь данные.");
      }
    } finally {
      setLoading(false);
    }
  }

  return (
    <main className="auth-page">
      <section className="auth-header">
        <h1>Система документов по практике</h1>
        <p>Авторизуйтесь или зарегистрируйтесь, чтобы создать документы.</p>
      </section>

      <section className="auth-grid">
        <form className="auth-card" onSubmit={handleLoginSubmit}>
          <h2>Авторизация</h2>

          <label>
            Логин
            <input
              type="text"
              name="username"
              value={loginForm.username}
              onChange={handleLoginChange}
              required
            />
          </label>

          <label>
            Пароль
            <input
              type="password"
              name="password"
              value={loginForm.password}
              onChange={handleLoginChange}
              required
            />
          </label>

          {loginError && <p className="error-text">{loginError}</p>}

          <button type="submit" disabled={loading}>
            Войти
          </button>
        </form>

        <form className="auth-card" onSubmit={handleRegisterSubmit}>
          <h2>Регистрация</h2>

          <label>
            ФИО
            <input
              type="text"
              name="full_name"
              value={registerForm.full_name}
              onChange={handleRegisterChange}
              required
            />
          </label>

          <label>
            ФИО в родительном падеже
            <input
              type="text"
              name="fio_genitive"
              value={registerForm.fio_genitive}
              onChange={handleRegisterChange}
              required
            />
          </label>

          <label>
            Логин
            <input
              type="text"
              name="username"
              value={registerForm.username}
              onChange={handleRegisterChange}
              required
            />
          </label>

          <label>
            Пароль
            <input
              type="password"
              name="password"
              value={registerForm.password}
              onChange={handleRegisterChange}
              required
            />
          </label>

          <label>
            Группа
            <input
              type="text"
              name="study_group"
              value={registerForm.study_group}
              onChange={handleRegisterChange}
              placeholder="Например: ИС-24"
            />
          </label>

          {registerError && <p className="error-text">{registerError}</p>}

          <button type="submit" disabled={loading}>
            Зарегистрироваться
          </button>
        </form>
      </section>
    </main>
  );
}

export default HomePage;