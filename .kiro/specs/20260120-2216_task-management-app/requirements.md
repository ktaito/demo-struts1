# Requirements: Task Management App

## Background & Context

### Current State
- Existing Struts1 demo application (Spotify song management)
- Working setup script (`setup-struts1.sh`) for one-command deployment
- Tech stack: Struts 1.3.10, MariaDB, Hibernate 5.6.15, Maven, Jetty

### User Problems
- Need a different sample application concept while maintaining the same technical foundation
- Want to reuse the existing setup infrastructure without breaking it
- Desire a simple, warm-toned design for better user experience

### Related Issues
- Must preserve all framework, database, and build configurations
- Must remain compatible with `setup-struts1.sh`
- Code volume and screen count should remain similar

## Objectives

Transform the Spotify song management app into a task management application with:
1. New domain model (tasks instead of songs)
2. Warm color scheme with simple design
3. Same technical stack and deployment process
4. Similar functionality scope (CRUD + pagination + authentication)

## Scope

### In Scope
- **Domain Change**: Spotify songs → Tasks
- **Data Model**: 
  - Table: `spotify_song` → `task`
  - Fields: task_title, assignee, category, priority, status
- **UI/UX**: Warm color palette (orange, beige tones), simple layout
- **Screens**: Login, Dashboard, Task List (with pagination), Task Init
- **Java Code**: Rename classes, packages, and logic to match task domain

### Out of Scope
- Framework changes (Struts 1.3.10 stays)
- Database engine changes (MariaDB stays)
- ORM changes (Hibernate 5.6.15 stays)
- Build tool changes (Maven stays)
- Server changes (Jetty stays)
- Database connection settings (host, port, credentials)
- pom.xml dependencies
- hibernate.cfg.xml connection config
- web.xml and struts-config.xml core structure

## Detailed Requirements

### Data Model

**Task Table**:
- `id`: BIGINT, AUTO_INCREMENT, PRIMARY KEY
- `task_title`: VARCHAR(100), NOT NULL (task name)
- `assignee`: VARCHAR(50), NOT NULL (person responsible)
- `category`: VARCHAR(50), NOT NULL (work/personal/shopping/etc.)
- `priority`: INT, NOT NULL (1-100, higher = more important)
- `status`: VARCHAR(20), NOT NULL (未着手/進行中/完了)

**Rationale**: Maintains similar structure to original `spotify_song` table (5 fields + id) to keep code complexity equivalent.

### Screens

1. **Login** (`login.jsp`): User authentication (unchanged functionality)
2. **Dashboard** (`dashboard.jsp`): Welcome screen with navigation
3. **Task List** (`taskList.jsp`): Display all tasks with pagination
4. **Task List Pagination** (`taskListPagination.jsp`): Paginated task view
5. **Task Init** (`taskInit.jsp`): Initialize/reset task data

### Design Requirements

**Color Scheme** (Warm tones):
- Primary: Orange (#FF8C42)
- Secondary: Beige (#F5E6D3)
- Accent: Coral (#FF6B6B)
- Background: Light cream (#FFF8F0)
- Text: Dark brown (#4A3F35)

**Design Principles**:
- Simple, clean layouts
- Minimal decoration
- Clear typography
- Consistent spacing
- Warm, inviting atmosphere

### Functional Requirements

1. **Authentication**: Login with username/password (existing user table)
2. **Task Display**: Show task list with all fields
3. **Pagination**: Navigate through tasks (10 per page)
4. **Task Initialization**: Reset task data to sample set
5. **Navigation**: Clear flow between screens

### Technical Constraints

**Must Preserve**:
- All Maven dependencies in `pom.xml`
- Hibernate configuration in `hibernate.cfg.xml`
- Struts configuration structure in `struts-config.xml`
- Web.xml servlet mappings
- Database connection parameters
- Jetty server configuration

**Rationale**: Ensures `setup-struts1.sh` continues to work without modification.

### Sample Data

Provide 15 sample tasks covering various categories, priorities, and statuses to demonstrate the application functionality.

---
**Created**: 2026-01-20
