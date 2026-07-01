// Variant is selected at compile time with `--input variant=<name>`.
// variant: "cv" (default), "website", or "nolinks".
#let variant = sys.inputs.at("variant", default: "cv")
#let for-website = variant == "website"
#let no-links = variant == "nolinks"

#set document(title: "Benjamin Andrew's CV", author: "Benjamin Andrew")
#set page(paper: "us-letter", margin: 2cm)
#set text(font: "XCharter", size: 10pt, fill: black)
#set par(justify: false, leading: 0.45em, spacing: 0.4em)
#set list(marker: [•], indent: 0pt, body-indent: 8pt, spacing: 0.1em)

#let entryspacing = 0.08cm

// Strip links entirely for the no-links variant, otherwise render as a
// normal (colored, underlined) hyperlink.
#let clink(url, body) = if no-links { body } else { link(url)[#underline(text(fill: blue, body))] }

#let section(title) = {
  v(0.2cm)
  text(weight: "bold", size: 12pt, title)
  v(1pt)
  line(length: 100%, stroke: 0.5pt)
  v(0.12cm)
}

#let cventry(date, title, body) = {
  grid(
    columns: (1fr, 4.5cm),
    column-gutter: 0.15cm,
    align(left, title),
    align(right, date),
  )
  v(0.05cm)
  body
}

// Header
#align(center)[
  #text(size: 25pt)[Ben M.~Andrew]

  #v(5pt)

  #text(size: 10pt)[
    #clink("mailto:benjamin.andrew@manchester.ac.uk", "benjamin.andrew@manchester.ac.uk")
    #h(5pt)|#h(5pt)
    #clink("http://benmandrew.com/", "benmandrew.com")
    #if not no-links [
      #h(5pt)|#h(5pt)
      #clink("https://linkedin.com/in/benmandrew", "linkedin.com")
      #h(5pt)|#h(5pt)
      #clink("https://github.com/benmandrew", "github.com")
    ]
  ]
]

#if for-website [
  #place(top + right, dy: -2cm)[
    #text(size: 8pt, fill: gray, style: "italic")[Last updated on Jun 27th, 2026]
  ]
]

#section[Education]

#cventry(
  [Sep 2024 -- Present],
  [*University of Manchester*, PhD in Computer Science],
)[
  - Research focused on formal methods for understanding degraded systems.
  - Supervised by #clink("https://mariefarrell.github.io/", "Dr. Marie Farrell"), #clink("https://personalpages.manchester.ac.uk/staff/louise.dennis/", "Dr. Louise Dennis"), and #clink("https://personalpages.manchester.ac.uk/staff/michael.fisher/", "Prof. Michael Fisher").
]

#v(entryspacing)

#cventry(
  [Oct 2019 -- Jun 2022],
  [*University of Cambridge*, BA (Hons) in Computer Science],
)[
  - Grade II.1 (70%).
  - Dissertation titled _Delay-Tolerant Link-State Routing_. Implemented and empirically evaluated a failure-tolerant routing protocol in C to run on real Unix-based routers, comparing with traditional protocols. Supervised by #clink("https://jacksonwoodruff.com/", "Dr. Jackson Woodruff").
]

#section[Publications]

- Andrew, B. M., Dennis, L. A., Fisher, M., Farrell, M. _Counterexample-Guided Interval Weakening_. Rigorous State-Based Methods (ABZ) 2026. #clink("https://doi.org/10.1007/978-3-032-26752-8_1", "10.1007/978-3-032-26752-8_1")

#v(entryspacing)

- Andrew, B. M. _Weakening Goals in Logical Specifications_. Rigorous State-Based Methods (ABZ) 2025. #clink("https://doi.org/10.1007/978-3-031-94533-5_22", "10.1007/978-3-031-94533-5_22")

#section[Industry Experience]

#cventry(
  [Sep 2022 -- Jun 2024],
  [*Software Engineer*, Tarides -- Paris, France],
)[
  - Developed open-source continuous integration (CI) software for the OCaml language's ecosystem, involving systems programming to distribute dependency solving, compilation, and testing to many operating systems and architectures.
  - Responsible for the CI of the Opam Repository, the central package universe for OCaml with tens of thousands of packages.
]

#v(entryspacing)

#cventry(
  [Jul -- Sep 2021],
  [*Embedded Systems Intern*, Tarides -- Paris, France],
)[
  - Research \& development project to cross-compile the OCaml bytecode runtime to an ARM-based microcontroller using a real-time operating system as a base layer.
]

#v(entryspacing)

#cventry(
  [Jun -- Sep 2020],
  [*Computer Graphics Research Intern*, University of Cambridge],
)[
  - Developed and implemented a visual model of ageing vision in virtual reality with Unity, as part of the Graphics and Displays Research Group.
]

#section[Professional Activities]

- Part of the local organising committee of Integrated Formal Methods (iFM) 2024.
- Member of the #clink("https://autonomy-and-verification.github.io", "Autonomy and Verification Network").

#section[Teaching Experience]

#cventry(
  [Oct 2022 -- Present],
  [*University of Cambridge*, Supervisor (TA equiv.)],
)[
  - Leading small group supervisions for undergraduate courses in computer science, including topics such as logic, formal verification, and semantics of programming languages.
]

#v(entryspacing)

#cventry(
  [Oct 2024 -- May 2026],
  [*University of Manchester*, Graduate Teaching Assistant],
)[
  - Assisting in teaching graduate and undergraduate courses in computer science, including topics such as software engineering, logic, and formal verification.
]
