# Tasks: Task Management App

## Implementation Checklist

### Phase 1: Database & Model Layer
- [x] Update `demo-struts1/demo.sql` - replace spotify_song table with task table
- [x] Add 15 sample task records to demo.sql
- [x] Rename `src/main/resources/model/spotify.hbm.xml` → `task.hbm.xml`
- [x] Update task.hbm.xml mapping (class name, table name, properties)
- [x] Rename `src/main/java/com/demo/struts1/model/SpotifySong.java` → `Task.java`
- [x] Update Task.java properties (taskTitle, assignee, category, priority, status)
- [x] Update `hibernate.cfg.xml` - change mapping resource to task.hbm.xml

### Phase 2: DAO Layer
- [x] Rename `src/main/java/com/demo/struts1/dao/SpotifyDAO.java` → `TaskDAO.java`
- [x] Update TaskDAO class name and methods (getAllTasks, getTasksPaginated, etc.)
- [x] Update DAO to use Task model instead of SpotifySong

### Phase 3: Controller Layer
- [x] Rename `SpotifyListAction.java` → `TaskListAction.java`
- [x] Update TaskListAction to use TaskDAO and Task model
- [x] Rename `SpotifyListPaginationAction.java` → `TaskListPaginationAction.java`
- [x] Update TaskListPaginationAction for task pagination
- [x] Rename `SpotifyInitAction.java` → `TaskInitAction.java`
- [x] Update TaskInitAction to initialize task data
- [x] Rename `SpotifyForm.java` → `TaskForm.java`
- [x] Update TaskForm properties (taskTitle, assignee, category, priority, status)

### Phase 4: Configuration
- [x] Update `struts-config.xml` - rename form-bean to taskForm
- [x] Update `struts-config.xml` - update action paths (/taskList.do, /taskListPagination.do, /taskInit.do)
- [x] Update `struts-config.xml` - update action classes to Task* classes
- [x] Update `struts-config.xml` - update forward paths to task JSPs
- [x] Update `tiles-defs.xml` - rename tile definitions (taskList, taskListPagination, taskInit)
- [x] Update `tiles-defs.xml` - update JSP paths

### Phase 5: View Layer - JSPs
- [x] Rename `spotifyList.jsp` → `taskList.jsp`
- [x] Update taskList.jsp - change table headers (Task, Assignee, Category, Priority, Status)
- [x] Update taskList.jsp - apply warm color CSS (orange, beige theme)
- [x] Rename `spotifyListPagination.jsp` → `taskListPagination.jsp`
- [x] Update taskListPagination.jsp - update display logic for tasks
- [x] Update taskListPagination.jsp - apply warm color CSS
- [x] Rename `spotifyInit.jsp` → `taskInit.jsp`
- [x] Update taskInit.jsp - change text to "Initialize Task Data"
- [x] Update taskInit.jsp - apply warm color CSS
- [x] Update `dashboard.jsp` - change links from spotify to task
- [x] Update `dashboard.jsp` - apply warm color CSS
- [x] Update `login.jsp` - apply warm color CSS (minimal changes)

### Phase 6: Common Components
- [x] Update `common/header.jsp` - change title to "Task Management"
- [x] Update `common/footer.jsp` - apply warm colors if needed
- [x] Update `common/menu.jsp` - change navigation links to task pages

### Phase 7: Validation & Testing
- [ ] Verify all files renamed correctly
- [ ] Check no references to "Spotify" or "spotify" remain in code
- [ ] Verify `setup-struts1.sh` still works without modification
- [ ] Test: Run `./setup-struts1.sh`
- [ ] Test: Access http://localhost:8081/demo-struts1/login.do
- [ ] Test: Login with demo_test1 / mypassword
- [ ] Test: Navigate to dashboard
- [ ] Test: View task list
- [ ] Test: Test pagination
- [ ] Test: Initialize task data
- [ ] Verify warm color scheme applied consistently

## Validation Criteria

### Files Exist
- [x] `.kiro/specs/20260120-2216_task-management-app/requirements.md`
- [x] `.kiro/specs/20260120-2216_task-management-app/design.md`
- [x] `.kiro/specs/20260120-2216_task-management-app/tasks.md`
- [x] `demo-struts1/src/main/java/com/demo/struts1/model/Task.java`
- [x] `demo-struts1/src/main/java/com/demo/struts1/dao/TaskDao.java`
- [x] `demo-struts1/src/main/java/com/demo/struts1/action/Task/TaskListAction.java`
- [x] `demo-struts1/src/main/resources/model/task.hbm.xml`
- [x] `demo-struts1/src/main/webapp/WEB-INF/view/taskList.jsp`

### Application Works
- [ ] `./setup-struts1.sh` executes successfully
- [ ] Application starts on http://localhost:8081/demo-struts1/
- [ ] Login page displays with warm colors
- [ ] Can login with test credentials
- [ ] Dashboard shows task navigation
- [ ] Task list displays sample data
- [ ] Pagination works
- [ ] Task initialization works

---
**Created**: 2026-01-20
