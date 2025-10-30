# Contributing to the Main Repository

Thank you for your interest in this repository! While this is primarily a personal collection of projects, feedback and suggestions are always welcome.

## Repository Purpose

This repository serves as a central hub for all public projects. It's designed to:

- Provide a single location to download all projects
- Make it easy to browse and discover different projects
- Maintain a complete archive of public work
- Serve as a portfolio and reference

## Suggesting Improvements

If you have suggestions for improvements:

1. **Open an Issue** - Describe your suggestion with details
2. **Provide Context** - Explain the benefit or problem it solves
3. **Be Specific** - Include examples or mockups if applicable

## Reporting Issues

Found a bug or problem? Please report it:

1. Check if the issue already exists
2. Create a new issue with:
   - Clear description of the problem
   - Steps to reproduce
   - Expected vs actual behavior
   - Environment details (OS, versions, etc.)

## Project Structure Guidelines

When adding new content to this repository:

### Projects (`projects/`)
- Complete, substantial applications
- Include comprehensive documentation
- Should have tests where applicable
- Follow a standard structure (src, tests, docs)

### Scripts (`scripts/`)
- Single-purpose automation scripts
- Include usage documentation in comments
- Specify dependencies clearly
- Include examples

### Tools (`tools/`)
- Standalone utilities
- More complex than scripts, simpler than full projects
- Self-contained with minimal dependencies
- Well-documented with examples

### Experiments (`experiments/`)
- Proof-of-concept code
- Learning exercises
- May be incomplete or work-in-progress
- Should include notes on purpose and findings

### Documentation (`docs/`)
- General guides and references
- Cross-project documentation
- Best practices and standards
- How-to guides

### Resources (`resources/`)
- Templates and boilerplates
- Shared configuration files
- Reusable assets
- Sample data

## Code Quality Standards

When adding code:

- **Documentation** - Include README files and code comments
- **Clarity** - Write clear, readable code
- **Dependencies** - Minimize and document dependencies
- **Licensing** - Respect licenses and provide attribution
- **Testing** - Include tests for non-trivial functionality

## Naming Conventions

- Use lowercase with hyphens for directory names: `my-project-name`
- Be descriptive but concise
- Avoid special characters except hyphens and underscores
- Use consistent naming within a project

## Commit Guidelines

- Use clear, descriptive commit messages
- Start with a verb (Add, Update, Fix, Remove, etc.)
- Reference issue numbers when applicable
- Keep commits focused on a single change

Example:
```
Add authentication module to user-management project

- Implement JWT-based authentication
- Add login/logout endpoints
- Include tests for auth flows

Fixes #123
```

## Questions?

Feel free to open an issue for questions or clarifications about contributing.

---

*This is a living document and may be updated as the repository evolves.*
