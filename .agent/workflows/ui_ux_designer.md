---
description: Sports-Themed App UI/UX Guidelines
---

# UI/UX Designer Guidelines for Sports App

## Color System
- **Primary**: `#007F3B` (Grass Green)
- **Secondary**: `#FFFFFF` (Court Line White)
- **Accent**: `#FFD600` (Tennis Ball Yellow)
- **Net Gray**: `#666666` (Neutral Gray)
- **Accessibility**: Level WCAG 2.1 AA
  - **Light Mode**: Background `#FFFFFF`, Text `#007F3B`
  - **Dark Mode**: Background `#121212`, Text `#FFD600`

## Typography System
- **Grid**: 8pt
- **Font Weights**:
  - **Bold**: 700
  - **Medium**: 500
  - **Regular**: 400
- **H1**: Size 40px, Line Height 48px, Weight 700
- **H2**: Size 32px, Line Height 40px, Weight 700
- **H3**: Size 24px, Line Height 32px, Weight 700
- **H4**: Size 20px, Line Height 28px, Weight 500
- **H5**: Size 16px, Line Height 24px, Weight 500
- **H6**: Size 14px, Line Height 20px, Weight 500
- **Subtitle**: Size 16px, Line Height 24px, Weight 400
- **Body**: Size 14px, Line Height 20px, Weight 400
- **Caption**: Size 12px, Line Height 16px, Weight 400

## Interaction Experience
- **Button Press Scale**: 0.96 animation for tactile feedback
- **Page Transitions**: Fade in/out to soften abrupt changes
- **Scroll Bounce**: Elastic overscroll effect like iOS

## Component Optimization
- **GlowButton**: Uses Primary, Secondary, and Text colors
- **Border Radius**:
  - **Small**: 12px
  - **Medium**: 16px
  - **Large**: 24px
- **Shadow**: `0 4px 12px rgba(0, 0, 0, 0.1)`

## Overall Layout
- **Golden Ratio**: Use 1:1.618 for key layout areas and whitespace
- **Minimum Touch Target**: 44×44pt
- **Progressive Disclosure**: Reveal information step-by-step

## Usability Principles
- **Visual Cues**: Clear hover, focus, and active states on all interactive elements
- **Form Simplification**: Only required fields, support social login/auto-fill
- **Error Feedback**: Red highlight + descriptive message + correction tips
