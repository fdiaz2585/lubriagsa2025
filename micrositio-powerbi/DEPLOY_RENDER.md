
# Despliegue del Backend en Render (Node + SQLite con Disk)

## 1) Requisitos
- Repositorio en GitHub/GitLab con esta estructura:
  - `backend/` (contiene `package.json`, `index.js`, `db.js`, rutas, etc.)

## 2) Opción A: Infrastructure as Code (recomendado)
1. Confirma que `render.yaml` está en la raíz del repo.
2. En Render: **New +** → **Blueprint** → conecta tu repo.
3. Render creará el servicio **micrositio-backend** y un **Disk** de 1 GB en `/data`.

Variables de entorno a definir en Render (el wizard te pedirá las marcadas como `sync:false`):
- `JWT_SECRET` → el mismo valor que usas localmente.
- `DATABASE_PATH` → `/data/database.db` (ya viene en `render.yaml`).

## 3) Opción B: Manual (si no usas `render.yaml`)
1. **Create New** → **Web Service** → conecta el repo.
2. **Root Directory**: `backend`
3. **Build Command**: `npm install`
4. **Start Command**: `npm start`
5. **Runtime**: Node 18
6. **Add Disk**:
   - Name: `micrositio-db`
   - Mount path: `/data`
   - Size: 1 GB (o más).
7. **Env Vars**:
   - `JWT_SECRET`: (tu secreto)
   - `DATABASE_PATH`: `/data/database.db`

## 4) Inicializar la base de datos (si parte vacía)
- Si tu app ya crea tablas en caliente, basta con acceder al backend.
- Si tienes script de init (`initDB.js`), ejecuta un **One-off Job**:
  - **Shell** → `node initDB.js`
- Para crear un admin:
  - **One-off Job** → `npm run crear-admin`

## 5) Probar
- Abre la URL pública que Render te asigna y visita `/` → debe responder JSON:
  ```json
  { "msg": "Backend micrositio PowerBI funcionando." }
  ```

## 6) Conectar con Netlify
- En Netlify agrega `VITE_API_URL = https://TU-SERVICIO-RENDER.onrender.com/api`
- Rebuild del sitio en Netlify.

## 7) Notas
- Render usa la variable `PORT` automáticamente; tu app ya la respeta.
- El archivo de BD vivirá en `/data/database.db` (persistente entre deploys).
