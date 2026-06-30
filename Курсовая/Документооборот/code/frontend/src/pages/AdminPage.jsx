import { useEffect, useState } from "react";
import { useNavigate } from "react-router-dom";

import api from "../api/api";

function AdminPage() {
  const navigate = useNavigate();

  const [triggerLogs, setTriggerLogs] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  async function loadTriggerLogs() {
    setLoading(true);
    setError("");

    try {
      const response = await api.get("/documents/trigger-logs/");
      setTriggerLogs(response.data);
    } catch (error) {
      console.log(error.response?.data);

      if (error.response?.status === 401) {
        setError("Вы не авторизованы.");
      } else if (error.response?.status === 403) {
        setError("Нет прав администратора.");
      } else {
        setError("Не удалось загрузить журнал SQL-триггеров.");
      }
    } finally {
      setLoading(false);
    }
  }

  useEffect(() => {
    const token = localStorage.getItem("access");

    if (!token) {
      navigate("/");
      return;
    }

    loadTriggerLogs();
  }, [navigate]);

  function handleLogout() {
    localStorage.removeItem("access");
    localStorage.removeItem("refresh");
    navigate("/");
  }

  if (loading) {
    return (
      <main className="page">
        <p>Загрузка админ-панели...</p>
      </main>
    );
  }

  return (
    <main className="page">
      <header className="page-header">
        <div>
          <h1>Панель администратора</h1>
          <p>Журнал событий, созданных SQL-триггерами базы данных.</p>
        </div>

        <div className="header-actions">
          <button
            type="button"
            className="secondary-button"
            onClick={() => navigate("/profile")}
          >
            Профиль
          </button>

          <button
            type="button"
            className="secondary-button"
            onClick={loadTriggerLogs}
          >
            Обновить
          </button>

          <button
            type="button"
            className="secondary-button"
            onClick={handleLogout}
          >
            Выйти
          </button>
        </div>
      </header>

      {error && <p className="error-text">{error}</p>}

      <section className="card">
        <h2>Журнал SQL-триггеров</h2>

        <p>
          Эта таблица показывает записи, которые автоматически добавляются в базу
          при срабатывании SQL-триггеров.
        </p>

        <div className="table-wrapper">
          <table className="admin-table">
            <thead>
              <tr>
                <th>ID</th>
                <th>Событие</th>
                <th>Таблица</th>
                <th>ID строки</th>
                <th>Сообщение</th>
                <th>Дата</th>
              </tr>
            </thead>

            <tbody>
              {triggerLogs.map((log) => (
                <tr key={log.id}>
                  <td>{log.id}</td>
                  <td>{log.event_type}</td>
                  <td>{log.table_name}</td>
                  <td>{log.row_id}</td>
                  <td>{log.message}</td>
                  <td>{new Date(log.created_at).toLocaleString()}</td>
                </tr>
              ))}

              {triggerLogs.length === 0 && (
                <tr>
                  <td colSpan="6">Журнал пока пуст.</td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </section>
    </main>
  );
}

export default AdminPage;