# Design: Task Management App

## Architecture Overview

Maintain existing Struts 1.3.10 MVC architecture:
- **Model**: Hibernate entities
- **View**: JSP with Tiles
- **Controller**: Struts Actions

## Data Layer

### Database Schema

```sql
CREATE TABLE IF NOT EXISTS task (
    id BIGINT NOT NULL AUTO_INCREMENT,
    task_title VARCHAR(100) NOT NULL,
    assignee VARCHAR(50) NOT NULL,
    category VARCHAR(50) NOT NULL,
    priority INT NOT NULL,
    status VARCHAR(20) NOT NULL,
    PRIMARY KEY (id)
);
```

### Hibernate Mapping

**File**: `src/main/resources/model/task.hbm.xml`

```xml
<hibernate-mapping>
    <class name="com.demo.struts1.model.Task" table="task">
        <id name="id" column="id">
            <generator class="identity"/>
        </id>
        <property name="taskTitle" column="task_title"/>
        <property name="assignee" column="assignee"/>
        <property name="category" column="category"/>
        <property name="priority" column="priority"/>
        <property name="status" column="status"/>
    </class>
</hibernate-mapping>
```

### Model Class

**File**: `src/main/java/com/demo/struts1/model/Task.java`

```java
public class Task {
    private Long id;
    private String taskTitle;
    private String assignee;
    private String category;
    private Integer priority;
    private String status;
    // getters/setters
}
```

## Controller Layer

### Actions (rename from Spotify* to Task*)

1. **TaskListAction** (was SpotifyListAction)
   - Fetch all tasks
   - Forward to taskList.jsp

2. **TaskListPaginationAction** (was SpotifyListPaginationAction)
   - Fetch paginated tasks
   - Forward to taskListPagination.jsp

3. **TaskInitAction** (was SpotifyInitAction)
   - Initialize sample task data
   - Redirect to task list

4. **LoginAction** (unchanged)
5. **LogoutAction** (unchanged)
6. **DashboardAction** (unchanged)

### Form Beans

**TaskForm** (was SpotifyForm):
- Properties: taskTitle, assignee, category, priority, status
- Validation: basic null checks

## View Layer

### JSP Files

1. **login.jsp**: Login form (minimal changes, update colors)
2. **dashboard.jsp**: Welcome screen with task navigation links
3. **taskList.jsp**: Display all tasks in table format
4. **taskListPagination.jsp**: Paginated task view with prev/next
5. **taskInit.jsp**: Initialize task data button
6. **success.jsp**: Success message
7. **failure.jsp**: Error message

### Design System

**CSS Variables** (inline in JSPs):
```css
:root {
    --primary: #FF8C42;
    --secondary: #F5E6D3;
    --accent: #FF6B6B;
    --bg: #FFF8F0;
    --text: #4A3F35;
}
```

**Typography**:
- Headers: 1.5-2rem, bold
- Body: 1rem, regular
- Font family: system fonts (Arial, sans-serif)

**Layout**:
- Max width: 1200px
- Padding: 20px
- Border radius: 8px
- Box shadow: subtle

## DAO Layer

### TaskDAO (was SpotifyDAO)

**File**: `src/main/java/com/demo/struts1/dao/TaskDAO.java`

Methods:
- `List<Task> getAllTasks()`
- `List<Task> getTasksPaginated(int offset, int limit)`
- `void initializeTasks()` - delete all, insert sample data
- `int getTaskCount()`

Reuse existing Hibernate session management pattern.

## Configuration Updates

### struts-config.xml

Update action mappings:
- `/taskList.do` → TaskListAction
- `/taskListPagination.do` → TaskListPaginationAction
- `/taskInit.do` → TaskInitAction

Update form-bean:
- `taskForm` → TaskForm

### tiles-defs.xml

Update tile definitions:
- `taskList` → taskList.jsp
- `taskListPagination` → taskListPagination.jsp
- `taskInit` → taskInit.jsp

### hibernate.cfg.xml

Update mapping resource:
```xml
<mapping resource="model/task.hbm.xml"/>
```

Remove:
```xml
<mapping resource="model/spotify.hbm.xml"/>
```

## Sample Data

15 tasks covering:
- Categories: 仕事, 個人, 買い物, 勉強, 家事
- Priorities: 20-95
- Statuses: 未着手, 進行中, 完了

## Implementation Strategy

### Reusable Components
- User authentication (LoginAction, User model, user.hbm.xml)
- Session management
- Hibernate configuration
- Maven build setup
- Jetty configuration

### New Components
- Task model, DAO, Actions, Forms
- Task JSPs with warm color design
- task.hbm.xml mapping
- Sample task data in demo.sql

### File Renaming Map

| Old | New |
|-----|-----|
| SpotifyListAction.java | TaskListAction.java |
| SpotifyListPaginationAction.java | TaskListPaginationAction.java |
| SpotifyInitAction.java | TaskInitAction.java |
| SpotifyForm.java | TaskForm.java |
| SpotifySong.java | Task.java |
| SpotifyDAO.java | TaskDAO.java |
| spotify.hbm.xml | task.hbm.xml |
| spotifyList.jsp | taskList.jsp |
| spotifyListPagination.jsp | taskListPagination.jsp |
| spotifyInit.jsp | taskInit.jsp |

---
**Created**: 2026-01-20
