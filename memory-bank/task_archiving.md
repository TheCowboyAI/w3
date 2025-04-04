# Task Archiving Process

This document outlines the standard process for archiving completed tasks in the CIM project.

## Archiving Steps

When a task is completed, follow these steps to properly archive it:

1. **Update Task Status**
   - Open the task file in `memory-bank/tasks/`
   - Update the status to "COMPLETED"
   - Add completion date and summary of work done

2. **Create Archive Entry**
   - Add a detailed entry to `docs/archive/completed_tasks.md`
   - Include the following sections:
     - Task ID and name
     - Completion date
     - Brief description
     - Key accomplishments
     - Technical implementation details
     - Challenges encountered and solutions
     - Lessons learned
     - Related tasks or dependencies

3. **Update Task Reference**
   - Move the task entry in `memory-bank/tasks.md` from "Active Tasks" to "Completed Tasks"
   - Update the link to point to the archived task file
   - Add completion date next to the task entry

4. **Update Related Documentation**
   - Update `progress.md` to reflect task completion
   - Move task from "In Progress" to "Completed Items" section
   - Add any relevant implementation details
   - Update `activeContext.md` to reflect current focus changes

5. **Organize Files**
   - Move the task file from `memory-bank/tasks/` to `docs/archive/tasks/`
   - Ensure all associated assets are properly organized

## Archive Entry Template

Use this template when adding entries to `docs/archive/completed_tasks.md`:

```markdown
## [Task ID]: [Task Name]

**Completed**: [Date]
**Related Tasks**: [List related task IDs if any]

### Description
[Brief description of the task and its objectives]

### Key Accomplishments
- [Key accomplishment 1]
- [Key accomplishment 2]
- [Key accomplishment 3]

### Implementation Details
[Technical details about the implementation]

### Challenges and Solutions
- **Challenge**: [Description of challenge]
  **Solution**: [Description of solution]
  
- **Challenge**: [Description of challenge]
  **Solution**: [Description of solution]

### Lessons Learned
- [Lesson 1]
- [Lesson 2]
- [Lesson 3]

### Follow-up Tasks
- [Follow-up task 1 if any]
- [Follow-up task 2 if any]
```

## Archiving Best Practices

1. **Be Comprehensive**: Include all relevant details in the archive entry
2. **Focus on Learning**: Emphasize lessons learned and insights gained
3. **Maintain Links**: Ensure all references to the task are updated
4. **Include Context**: Provide enough context for future understanding
5. **Track Dependencies**: Note relationships to other tasks
6. **Highlight Challenges**: Document difficulties and their solutions 