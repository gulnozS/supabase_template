# Flutter + Supabase Template

Simple, production-ready Flutter template with Supabase auth and a sample
feature, built to be easy to follow and easy to scale.

## What this template gives you

- Email auth flow (sign up, sign in, sign out, restore session)
- Supabase configuration via `.env`
- Clear feature structure (`data` / `domain` / `presentation`)
- Riverpod for dependency injection and async state
- One concrete feature (`reminders`) you can copy for new modules

## Quick start (5 minutes)

1. Install deps:
   - `flutter pub get`
2. Create env file:
   - `cp .env.example .env`
3. Set Supabase keys in `.env`:
   - `SUPABASE_URL=https://<project-ref>.supabase.co`
   - `SUPABASE_ANON_KEY=<anon-key>`
4. Create sample table in Supabase (SQL below).
5. Run:
   - `flutter run`

## Supabase SQL for sample feature

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

## How the app starts

Follow this order when reading the project:

1. `lib/main.dart`
   - Loads `.env`
   - Initializes Supabase
   - Starts Riverpod scope
2. `lib/src/app/app.dart`
   - App theme + root `MaterialApp`
   - Starts at `AuthGate`
3. `lib/src/features/auth/presentation/screens/auth_gate.dart`
   - Restores session
   - Routes user to sign in or reminders screen

## Project structure and what each part is for

```txt
lib/
  main.dart                 # App bootstrap: env + Supabase + ProviderScope
  src/
    app/
      app.dart              # MaterialApp setup (theme, root screen)
    core/
      config/               # Global setup (env loading, Supabase init)
      constants/            # Shared constants (table names, keys)
      error/                # App-level exception mapping
      theme/                # Light/dark theme config
    features/
      <feature_name>/
        data/               # External I/O (Supabase/API), DTO/model mapping
        domain/             # Business contracts + use-cases, framework-free
        presentation/       # UI, state controllers/providers, screens/widgets
test/                       # Unit/widget tests
```

## Layer responsibilities (keep this rule in every project)

- `presentation`
  - Knows UI and user actions.
  - Calls use-cases.
  - Never talks directly to Supabase client.
- `domain`
  - Knows business logic.
  - Defines repository interfaces + use-cases.
  - No Flutter/Supabase-specific code.
- `data`
  - Knows Supabase/network/storage details.
  - Implements domain repositories.
  - Maps JSON/DTO to domain entities.

## End-to-end flow (how data moves)

1. UI screen triggers action.
2. Controller/provider calls a use-case.
3. Use-case calls domain repository interface.
4. Data repository implementation calls Supabase data source.
5. Result maps back to domain entity.
6. Provider emits new state to UI.

## Dependencies and why they are used

- `supabase_flutter`
  - Auth, database, storage client.
- `flutter_riverpod`
  - Dependency injection + async state (`Provider`, `FutureProvider`,
    `StreamProvider`, `StateNotifierProvider`).
- `flutter_dotenv`
  - Read runtime environment config from `.env`.

## How to add a new feature (copy-paste recipe)

Create this structure:

```txt
lib/src/features/tasks/
  data/
    datasources/
      task_remote_data_source.dart
    models/
      task_model.dart
    repositories/
      task_repository_impl.dart
  domain/
    entities/
      task.dart
    repositories/
      task_repository.dart
    usecases/
      get_tasks_use_case.dart
  presentation/
    controllers/
      tasks_controller.dart
    screens/
      tasks_screen.dart
    widgets/
      task_tile.dart
```

Implementation order (always same):

1. Domain entity + repository contract.
2. Use-case(s) in domain.
3. Data source + model + repository implementation.
4. Provider/controller wiring in presentation.
5. Screen + widgets.
6. Unit test for model/use-case.

## Rules to keep template consistent across projects

- Feature-first folders under `lib/src/features`.
- Same 3 layers in every feature: `data/domain/presentation`.
- One responsibility per file/class.
- Domain layer should not import Flutter or Supabase packages.
- Controllers expose `AsyncValue` to keep loading/error handling consistent.
- Secrets only in `.env`; never hardcode keys.

## Common edits and where to do them

- Change app theme: `lib/src/core/theme/app_theme.dart`
- Change auth flow UI: `lib/src/features/auth/presentation/screens/`
- Add Supabase table constants: `lib/src/core/constants/supabase_tables.dart`
- Add/adjust env keys: `.env.example` and `lib/src/core/config/env_config.dart`

## Troubleshooting

- App fails on startup with env error:
  - Check `.env` exists and has valid `SUPABASE_URL` and `SUPABASE_ANON_KEY`.
- Auth state not updating:
  - Verify `authStateProvider` stream is used in `AuthGate`.
- Empty reminders list:
  - Confirm table exists and RLS policy allows current user to read own rows.
