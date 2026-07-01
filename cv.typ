// Variant is selected at compile time with `--input variant=<name>`.
// variant: "cv" (default), "website", or "nolinks".
#let variant = sys.inputs.at("variant", default: "cv")
#let for-website = variant == "website"
#let no-links = variant == "nolinks"

#set document(title: "Benjamin Andrew's CV", author: "Benjamin Andrew")
#set page(paper: "us-letter", margin: 2cm)
#set text(font: "XCharter", size: 10pt, fill: black)
#set par(justify: false, leading: 0.55em, spacing: 0.4em)
#set list(marker: [•], indent: 0pt, body-indent: 8pt, tight: false, spacing: 0.26cm)

#let entryspacing = 0.20cm

// Strip links entirely for the no-links variant, otherwise render as a
// normal (colored, underlined) hyperlink.
#let clink(url, body) = if no-links { body } else { link(url)[#underline(text(fill: blue, body))] }

#let section(title) = {
  v(0.3cm)
  text(weight: "bold", size: 12pt, title)
  v(1pt)
  line(length: 100%, stroke: 0.5pt)
  v(0.2cm)
}

#let cventry(date, title, body) = {
  grid(
    columns: (1fr, 4.5cm),
    column-gutter: 0.15cm,
    align(left, title),
    align(right, date),
  )
  v(0.1cm)
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
  #place(top + right, dy: -1cm)[
    #text(size: 8pt, fill: gray, style: "italic")[Last updated on Jun 27th, 2026]
  ]
]

#section[Education]

#cventry(
  [Sep 2024 -- Present],
  [*University of Manchester*, PhD in Computer Science],
)[
  - Research focused on formal verification of degraded systems.
  - Supervised by #clink("https://mariefarrell.github.io/", "Dr. Marie Farrell"), #clink("https://personalpages.manchester.ac.uk/staff/louise.dennis/", "Dr. Louise Dennis"), and #clink("https://personalpages.manchester.ac.uk/staff/michael.fisher/", "Prof. Michael Fisher").
]

#v(entryspacing)

#cventry(
  [Oct 2019 -- Jun 2022],
  [*University of Cambridge*, BA (Hons) in Computer Science],
)[
  - Grade II.1 (70%).
  - Dissertation titled _Delay-Tolerant Link-State Routing_. Implemented and empirically evaluated a failure-tolerant routing protocol in C to run on real Unix-based routers, comparing it against traditional protocols. Supervised by #clink("https://jacksonwoodruff.com/", "Dr. Jackson Woodruff").
]

#section[Publications]

- Andrew, B. M., Dennis, L. A., Fisher, M., Farrell, M. _Counterexample-Guided Interval Weakening_. Rigorous State-Based Methods (ABZ) 2026. #clink("https://doi.org/10.1007/978-3-032-26752-8_1", "10.1007/978-3-032-26752-8_1")

#v(entryspacing)

- Andrew, B. M. _Weakening Goals in Logical Specifications_. Rigorous State-Based Methods (ABZ) 2025. #clink("https://doi.org/10.1007/978-3-031-94533-5_22", "10.1007/978-3-031-94533-5_22")

#section[Skills]

*Programming Languages:* OCaml, C++, C, Python, Rust

#v(entryspacing)

#grid(
  columns: (1fr, 1fr),
  column-gutter: 0.15cm,
  [*Tools:* Git, Docker, Claude Code],
  [*Spoken Languages:* English, French],
)

#section[Industry Experience]

#cventry(
  [Sep 2022 -- Jun 2024],
  [*Software Engineer*, Tarides -- Paris, France],
)[
  - Built open-source CI infrastructure for the OCaml ecosystem, distributing dependency solving, compilation, and testing across a broad matrix of operating systems, CPU architectures, and compiler versions.
  - Tested tens of thousands of packages across the Opam Repository, OCaml's central package universe.
  - Exposed concrete bugs in the OCaml 5 multicore runtime through systematic stress-testing, reporting and tracking them to resolution upstream.
]

#v(entryspacing)

#cventry(
  [Jul -- Sep 2021],
  [*Embedded Systems Intern*, Tarides -- Paris, France],
)[
  - Cross-compiled the OCaml bytecode runtime to an ARM-based microcontroller running a real-time operating system, as part of an R\&D project.
]

#v(entryspacing)

#cventry(
  [Jun -- Sep 2020],
  [*Computer Graphics Research Intern*, University of Cambridge],
)[
  - Developed and implemented a visual model of ageing vision in virtual reality with Unity, as part of the Graphics and Displays Research Group.
]

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
  - Assisted in teaching graduate and undergraduate courses in computer science, including topics such as software engineering, logic, and formal verification.
]
