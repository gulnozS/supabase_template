# Flutter + Supabase Clean Template

Production-grade Flutter template using Supabase, Riverpod, and clean
architecture.

## Features

- Supabase auth (sign up, sign in, sign out, session restore)
- Environment-based Supabase config via `.env`
- Clean architecture separation:
  - `core`
  - `features/.../data`
  - `features/.../domain`
  - `features/.../presentation`
- Example reminders feature from Supabase table
- Loading and error handling with Riverpod `AsyncValue`

## Folder Structure

```txt
lib/
  main.dart
  src/
    app/
      app.dart
    core/
      config/
        env_config.dart
        supabase_initializer.dart
      constants/
        supabase_tables.dart
      error/
        app_exception.dart
      theme/
        app_theme.dart
    features/
      auth/
        data/
          datasources/
            auth_remote_data_source.dart
          repositories/
            auth_repository_impl.dart
        domain/
          entities/
            auth_user.dart
          repositories/
            auth_repository.dart
          usecases/
            restore_session_use_case.dart
            sign_in_use_case.dart
            sign_out_use_case.dart
            sign_up_use_case.dart
        presentation/
          controllers/
            auth_controller.dart
          screens/
            auth_gate.dart
            sign_in_screen.dart
            sign_up_screen.dart
      reminders/
        data/
          datasources/
            reminder_remote_data_source.dart
          models/
            reminder_model.dart
          repositories/
            reminder_repository_impl.dart
        domain/
          entities/
            reminder.dart
          repositories/
            reminder_repository.dart
          usecases/
            get_reminders_use_case.dart
        presentation/
          controllers/
            reminders_controller.dart
          screens/
            reminders_screen.dart
          widgets/
            reminder_tile.dart
test/
  reminder_model_test.dart
.env.example
```

## Dependencies (`pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  flutter_dotenv: ^5.2.1
  flutter_riverpod: ^2.6.1
  supabase_flutter: ^2.12.0
```

## Setup

1. Install latest stable Flutter:
   - `flutter upgrade`
   - `flutter --version`
2. Install dependencies:
   - `flutter pub get`
3. Copy env file:
   - `cp .env.example .env`
4. Update `.env` with your project values:
   - `SUPABASE_URL=https://<project-ref>.supabase.co`
   - `SUPABASE_ANON_KEY=<anon-key>`
5. Create table in Supabase SQL editor:

```sql
create table if not exists public.reminders (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  description text,
  due_at timestamptz,
  created_at timestamptz not null default now()
);

alter table public.reminders enable row level security;

create policy "Users can read own reminders"
on public.reminders for select
to authenticated
using (auth.uid() = user_id);
```

6. Run app:
   - `flutter run`

## Scalability Notes

- Feature modules are isolated by `data/domain/presentation`.
- Use-cases keep business actions explicit and testable.
- Repository interfaces decouple UI/domain from Supabase-specific logic.
- Providers handle dependency injection and async state centrally.
