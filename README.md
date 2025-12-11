# Campus Planner

Aplikasi manajemen jadwal dan tugas untuk mahasiswa yang membantu mengorganisir aktivitas akademik dengan lebih efisien.

## 📱 Tentang Aplikasi

**Campus Planner** adalah aplikasi mobile berbasis Flutter yang dirancang khusus untuk membantu mahasiswa dalam mengelola jadwal kuliah, tugas (assignments), catatan (notes), dan aktivitas harian. Aplikasi ini menyediakan antarmuka yang intuitif untuk meningkatkan produktivitas dan mengatur waktu dengan lebih baik.

### Fitur Utama

- 🔐 **Autentikasi Lengkap** - Sistem login dan registrasi yang aman untuk melindungi data pengguna
- 📚 **Manajemen Tugas (Assignments)** - Kelola tugas kuliah dengan deadline, status completion, dan reminder
- 📅 **Jadwal Kuliah (Schedule)** - Atur jadwal kelas, event, dan meeting dengan fitur recurring schedule
- 📝 **Catatan (Notes)** - Buat dan kelola catatan penting untuk kuliah atau keperluan lainnya
- ✅ **Task Today** - Catat dan pantau tugas harian yang perlu diselesaikan hari ini
- 👤 **Manajemen Profil** - Update informasi pribadi, kampus, jurusan, semester, dan foto profil
- 🌐 **Network Status Monitor** - Deteksi otomatis status koneksi internet dengan notifikasi real-time

## 🏗️ Arsitektur Aplikasi

Aplikasi menggunakan **Layered Architecture** yang memisahkan tanggung jawab menjadi tiga lapisan:

```
UI (Pages) 
    ↓
Repository (Business Logic)
    ↓
Service (HTTP API Client)
    ↓
Backend API
```

### Struktur Lapisan

1. **Presentation Layer (UI/Pages)**
   - LoginPage, RegisterPage, HomePage, ProfilePage
   - AssignmentsPage, NotesPage, SchedulePage
   - Bertanggung jawab untuk tampilan dan interaksi pengguna

2. **Business Logic Layer (Repository)**
   - AuthRepository, HomeRepository, AssignmentRepository
   - NotesRepository, ScheduleRepository, TaskRepository, ProfileRepository
   - Mengatur alur data, validasi, dan pemrosesan logika bisnis

3. **Data Layer (Service/API Client)**
   - AuthService, AssignmentService, NotesService
   - ScheduleService, TaskService, ProfileService, HomeService
   - Berkomunikasi dengan backend melalui HTTP requests

## 🔌 API Endpoints

Base URL: `https://zahraapi.xyz/campus_api/index.php`

### Authentication
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| POST | `?path=users&action=login` | Login pengguna |
| POST | `?path=users&action=register` | Registrasi pengguna baru |

**Login Request Body:**
```json
{
  "email": "example@gmail.com",
  "password": "123456"
}
```

**Register Request Body:**
```json
{
  "name": "John Doe",
  "email": "example@gmail.com",
  "password": "123456",
  "campus": "UIN Malang",
  "major": "Teknik Informatika",
  "semester": 5,
  "profile_image": "base64_string_optional"
}
```

**Login Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "example@gmail.com",
    "campus": "UIN Malang",
    "major": "Teknik Informatika",
    "semester": 5,
    "profile_image": "base64_string"
  }
}
```

**Register Response:**
```json
{
  "success": true,
  "message": "User registered"
}
```

### Assignments (Tasks)
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `?path=tasks&user_id={ID}` | Ambil semua assignment |
| POST | `?path=tasks` | Buat assignment baru |
| PUT | `?path=tasks&id={ID}` | Update assignment |
| DELETE | `?path=tasks&id={ID}` | Hapus assignment |

**Request Body (POST/PUT):**
```json
{
  "user_id": 1,
  "title": "Tugas Pemrograman",
  "description": "Bab 1-3",
  "time": "08:00",
  "deadline": "2025-01-20",
  "status": 0
}
```

### Notes
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `?path=notes&user_id={ID}` | Ambil semua notes |
| POST | `?path=notes` | Buat note baru |
| PUT | `?path=notes&id={ID}` | Update note |
| DELETE | `?path=notes&id={ID}` | Hapus note |

### Schedule
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `?path=schedule&user_id={ID}&date={YYYY-MM-DD}` | Ambil jadwal |
| POST | `?path=schedule` | Buat jadwal baru |
| PUT | `?path=schedule&id={ID}` | Update jadwal |
| DELETE | `?path=schedule&id={ID}` | Hapus jadwal |

**Fitur Khusus:**
- Mendukung recurring schedule (jadwal berulang mingguan)
- Menyimpan lokasi, dosen, dan catatan tambahan

### Task Today
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `?path=tasktoday&user_id={ID}` | Ambil task hari ini |
| POST | `?path=tasktoday` | Buat task hari ini |
| PUT | `?path=tasktoday&id={ID}` | Update task |
| DELETE | `?path=tasktoday&id={ID}` | Hapus task |

### Profile (Users)
| Method | Endpoint | Deskripsi |
|--------|----------|-----------|
| GET | `?path=users&id={ID}` | Ambil data profil |
| GET | `?path=users` | Ambil semua users |
| PUT | `?path=users&id={ID}` | Update profil |
| DELETE | `?path=users&id={ID}` | Hapus user |

**Update Profil Support:**
- Nama, email, kampus, jurusan, semester
- Upload foto profil (Base64)
- Update password (opsional)

### Format Response
**Success:**
```json
{
  "success": true,
  "message": "Operation successful",
  "data": [...]
}
```

**Error:**
```json
{
  "success": false,
  "message": "Error message"
}
```

## 🚀 Instalasi

### Prasyarat
- Flutter SDK (versi 3.0 atau lebih baru)
- Dart SDK
- Android Studio / VS Code dengan plugin Flutter
- Emulator Android atau perangkat fisik untuk testing

### Dependencies
Aplikasi ini menggunakan package berikut:
```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^1.2.2              # HTTP client untuk API calls
  connectivity_plus: ^6.1.2  # Network connectivity monitoring
  image_picker: ^1.1.2       # Upload foto profil
  intl: ^0.19.0             # Format tanggal dan waktu
```

### Langkah Instalasi

1. **Clone Repository**
```bash
git clone <repository-url>
cd campus-planner
```

2. **Install Dependencies**
```bash
flutter pub get
```

3. **Konfigurasi API**
   - Pastikan base URL API sudah sesuai di file service
   - Base URL: `https://zahraapi.xyz/campus_api/index.php`

4. **Run Aplikasi**
```bash
# Jalankan di debug mode
flutter run

# Atau build APK
flutter build apk --release
```

5. **Testing**
```bash
# Run unit tests
flutter test
```

## 📂 Struktur Folder

```
lib/
├── main.dart                       # Entry point aplikasi

├── pages/                          # Semua UI Pages
│   ├── login_page.dart            # Halaman login
│   ├── register_page.dart         # Halaman registrasi 
│   ├── home_page.dart             # Dashboard utama
│   ├── main_navigation.dart       # Bottom navigation
│   ├── add_assignment_page.dart   # Tambah assignment
│   ├── edit_assignment_page.dart  # Edit assignment
│   ├── assignments_page.dart      # List assignments
│   ├── assignments_detail_page.dart # Detail assignment
│   ├── add_schedule_page.dart     # Tambah jadwal
│   ├── schedule_page.dart         # List jadwal
│   ├── schedule_detail_page.dart  # Detail jadwal
│   ├── add_task_page.dart         # Tambah task today
│   ├── notes_page.dart            # List notes
│   └── profile_page.dart          # Halaman profil

├── repositories/                   # Layer Repository (Business Logic)
│   ├── auth_repository.dart       # Auth logic (login & register)
│   ├── assigment_repository.dart  # Assignment logic
│   ├── home_repository.dart       # Home dashboard logic
│   ├── notes_repository.dart      # Notes logic
│   ├── schedule_repository.dart   # Schedule logic
│   ├── profile_repository.dart    # Profile logic
│   └── task_repository.dart       # Task today logic

├── services/                       # API Service Layer
│   ├── auth_service.dart          # Auth API calls
│   ├── assignment_service.dart    # Assignment API calls
│   ├── home_service.dart          # Home API calls
│   ├── notes_service.dart         # Notes API calls
│   ├── schedule_service.dart      # Schedule API calls
│   ├── profile_service.dart       # Profile API calls
│   └── task_service.dart          # Task API calls

├── utils/                          # Utility Files
│   └── network_wrrapper.dart      # Network status wrapper

└── widgets/                        # Component Widgets
│    ├── network_checker_widget.dart      # Network checker
     └── network_status_indicator.dart    # Status indicator
                   

```

## ✨ Fitur Unggulan

### 1. Sistem Autentikasi Lengkap
- **Login**: Validasi email dan password dengan error handling
- **Register**: Form registrasi dengan validasi lengkap
  - Field wajib: Nama, Email, Password, Konfirmasi Password
  - Field opsional: Kampus, Jurusan, Semester
  - Validasi format email
  - Validasi panjang password minimal 6 karakter
  - Validasi password match

### 2. Network Status Monitor
- Deteksi otomatis koneksi internet hilang/kembali
- Notifikasi SnackBar dengan warna indikator:
  - 🔴 Merah: Tidak ada koneksi
  - 🟢 Hijau: Koneksi kembali normal
- Overlay transparan saat offline (opsional)

### 3. Clean Architecture
- Pemisahan layer yang jelas (UI → Repository → Service)
- Mudah untuk testing dan maintenance
- Reusable components

### 4. Modern UI/UX
- Material Design 3
- Konsisten color scheme (Indigo primary)
- Smooth animations
- Responsive layout
- Loading indicators

## 🔒 Keamanan

- Password di-hash menggunakan bcrypt di backend
- Validasi input di frontend dan backend
- Protected routes (cek authentication state)
- CORS enabled untuk mobile apps

## 🐛 Error Handling

Aplikasi dilengkapi dengan error handling pada:
- Network errors (timeout, no connection)
- API errors (4xx, 5xx responses)
- Validation errors (invalid input)
- Empty state handling

## 📱 Screenshot

<!-- TODO: Tambahkan screenshot aplikasi -->

## 🔄 Development Workflow

### Menambah Fitur Baru

1. **Buat Service** (`services/`)
   - Define API endpoints
   - Implementasi HTTP calls

2. **Buat Repository** (`repositories/`)
   - Business logic
   - Data validation
   - Error handling

3. **Buat UI** (`pages/`)
   - Design interface
   - Connect dengan repository
   - Handle states (loading, error, success)

### Code Style
- Gunakan snake_case untuk file names
- Gunakan camelCase untuk variables dan functions
- Gunakan PascalCase untuk class names
- Tambahkan komentar untuk logika kompleks

## 🚧 Roadmap

- [ ] Implement forgot password feature
- [ ] Add dark mode support
- [ ] Implement push notifications untuk deadline
- [ ] Add data synchronization
- [ ] Implement offline mode dengan local storage
- [ ] Add export/import data feature
- [ ] Multi-language support (ID/EN)

## 🤝 Contributing

Untuk kontribusi:
1. Fork repository
2. Buat branch baru (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Buat Pull Request

## 👨‍💻 Developer

**Zahra Tunnihaya Romo**
- NIM: 230605110141
- Kelas: A
- Program Studi: Teknik Informatika
- Fakultas Sains dan Teknologi
- Universitas Islam Negeri Maulana Malik Ibrahim Malang

## 📞 Contact

- Email: zahratunnihayaromo@gmail.com
- GitHub: [@zahratunnihaya](https://github.com/zahratunnihaya)

## 📝 Lisensi

Project ini dibuat untuk keperluan akademik - Mobile Programming (Ganjil 2025/2026)

## 🙏 Acknowledgments

- Flutter Documentation
- Material Design Guidelines
- API Backend PHP dengan MySQL
- Dosen Pengampu: [Nama Dosen]

---

**Tanggal Pembuatan:** 08 Desember 2025
**Last Updated:** 10 Desember 2025
