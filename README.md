# Thinking in SwiftUI - Code Companion

A visual and interactive companion guide to the book *Thinking in SwiftUI*, transforming its dense theoretical content into traceable, hands-on code examples.

> **⚠️ WORK IN PROGRESS - DRAFT MODE**
>
> This project is currently under active development and serves as a personal reference while reading through the book. The code is not organized, styled, or polished for public sharing yet. Examples are being added incrementally as pain points are encountered during reading. Once the book is finished and the project is refined, it will be ready to share with others.

## Overview

> **Note:** This is an unofficial companion project created by a reader. It is not affiliated with or endorsed by the authors of *Thinking in SwiftUI*.

The book *Thinking in SwiftUI* is widely regarded as one of the best resources for deeply understanding SwiftUI's mental models and layout system. However, at just 152 pages, it's intentionally minimal—favoring brevity over extensive examples and visuals. This density can make certain concepts ambiguous or difficult to grasp on first read.

This project bridges that gap by:
- **Visualizing** abstract concepts through interactive SwiftUI previews
- **Expanding** on minimal book examples with comprehensive code demonstrations
- **Clarifying** ambiguous explanations through traceable implementations
- **Exploring** deeper into what's happening behind the hood

Each file transforms a concept from the book into live, runnable code that you can see, modify, and experiment with in Xcode previews.

## Current Status

**What's done:**
- Layout containers (ScrollView, HStack, VStack, ZStack, etc.)
- Core layout modifiers (frame, fixedSize, padding, aspectRatio, etc.)
- Shape behaviors and examples
- Common layout patterns and pitfalls

**In progress:**
- Reading through the book and adding examples for difficult concepts
- Organizing and refactoring existing code
- Adding more comprehensive previews

**To do:**
- Complete remaining chapters
- Polish and style all examples
- Organize file structure
- Add consistent documentation
- Create unified visual style

## Project Structure

### Layout System

#### Containers
Detailed explanations of how SwiftUI containers handle layout:
- **ScrollView** - Layout behavior along scroll axes, content sizing, and common pitfalls
- **HStack/VStack** - Stack layout algorithms and spacing
- **ZStack** - Overlay layout behavior
- **List** - List layout and performance
- **GeometryReader** - Reading and responding to geometry
- **Grid** - Fixed columns and grid layouts

#### Modifiers
Deep dives into layout modifiers:
- **Frame Modifiers** - Fixed frames, flexible frames, ideal sizes, and conflicts
- **fixedSize()** - How it proposes nil to get ideal sizes
- **aspectRatio()** - Aspect ratio constraints and content modes
- **padding()** - Padding behavior and precedence
- **overlay()/background()** - Layering and sizing behavior
- **clipped()** - Clipping and layout boundaries

#### Shapes
Understanding shape layout behavior:
- **Basic Shapes** - Rectangle, Circle, RoundedRectangle
- **Custom Shapes** - Creating custom shapes
- **Color & Safe Area** - Color bleed and safe area handling

#### Layout Concepts
- **Layout vs Rendering** - The distinction between layout and rendering phases
- **Parent-Child Size Conflicts** - How SwiftUI resolves size conflicts
- **Spacer & Divider** - Behavior and use cases

### Custom Layout
Examples of creating custom layouts using SwiftUI's Layout protocol.

## Key Concepts Covered

### SwiftUI Layout Process
1. Parent proposes a size to child
2. Child chooses its own size
3. Parent positions the child

### Common Patterns
- How nil proposals work (unlimited space)
- Ideal sizes and default behaviors
- Frame modifier precedence
- Content mode behaviors
- Safe area and edge cases

## How to Use This Project

**Personal reference workflow:**
1. Read a section in *Thinking in SwiftUI*
2. If a concept is confusing or abstract, create/update a corresponding file
3. Write code examples to visualize the concept
4. Use Xcode previews to see it in action
5. Experiment and iterate until it clicks

**If you stumbled upon this repo:**
- Feel free to browse the code for your own learning
- Be aware that organization and style are inconsistent
- Examples are added based on personal pain points, not comprehensive coverage
- Wait for v1.0 if you want a polished, shareable resource

Each file currently contains:
- Comments mapping to book concepts (varying levels of detail)
- Multiple view examples demonstrating different scenarios
- Interactive previews (some with tabbed navigation, some separate)
- Problem/solution pairs showing common mistakes
- Additional explorations beyond the book's scope

## Topics Covered

### Beginner
- Basic container layout (HStack, VStack, ZStack)
- Simple frame modifiers
- Padding and spacing
- Basic shapes

### Intermediate
- ScrollView layout behavior
- Fixed vs flexible frames
- AspectRatio and content modes
- fixedSize() modifier
- Overlay and background

### Advanced
- Parent-child size conflicts
- Layout vs rendering phases
- Custom layouts
- Geometry reader patterns
- Advanced frame combinations

## Note on Organization

The file structure roughly follows the book's chapters, but organization is still evolving. Some concepts are split across multiple files, others are combined. This will be cleaned up and made more logical in future iterations.

## Requirements

- iOS 15.0+
- Xcode 15.0+
- Swift 5.9+

## Author

Created by Ali Abdelkhalek

## License

This is a personal educational project. The code examples are for learning purposes and are based on concepts from the book *Thinking in SwiftUI*. Not currently licensed for distribution or reuse until v1.0.

## Why This Project Exists

While *Thinking in SwiftUI* is an excellent reference for learning SwiftUI in depth, its minimalist approach (152 pages covering complex topics) can sometimes be:
- **Too dense** - Packing multiple concepts into brief paragraphs
- **Ambiguous** - Abstract explanations without concrete visual feedback
- **Minimal** - Few examples and limited visual illustrations

This project addresses these challenges by providing:
- **Visual feedback** - See exactly what each concept does in real-time
- **Multiple examples** - Problem/solution pairs and edge cases
- **Interactive exploration** - Modify code and immediately see results
- **Deeper investigations** - Go beyond the book when needed

## Contributing

This is currently a personal learning project and not accepting contributions. Once the project reaches a stable, polished state (v1.0), contributions will be welcomed for:
- Additional examples for confusing concepts
- Improvements to existing explanations
- Better organization and structure
- Visual enhancements

## Related Resources

- [Thinking in SwiftUI](https://www.objc.io/books/thinking-in-swiftui/) - The companion book
- [objc.io](https://www.objc.io/) - Publisher of Thinking in SwiftUI
- [Apple's SwiftUI Documentation](https://developer.apple.com/documentation/swiftui/) - Official reference
