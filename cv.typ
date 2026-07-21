// Variant is selected at compile time with `--input variant=<name>`.
// variant: "cv" (default), "website", or "nolinks".
#let variant = sys.inputs.at("variant", default: "cv")
#let for-website = variant == "website"
#let no-links = variant == "nolinks"

#set document(title: "Benjamin Andrew's CV", author: "Benjamin Andrew")
#set page(paper: "us-letter", margin: 2cm)
#set text(font: "Libertinus Serif", size: 10pt, fill: black)

// Base spacing values. Every piece of vertical whitespace that should stretch —
// paragraph leading, list-item spacing, and the inter-entry / inter-section
// block gaps — is multiplied by a single scale factor `k`, solved for below so
// the content expands proportionally to fill exactly one page. Typst's `fr`
// units can't drive `leading` or list `spacing` (they only work in block-level
// `v()`), so instead of fr we measure the body and compute `k` directly.
#let base-leading = 0.55em
#let base-list = 0.26cm
#let base-entry = 0.20cm
#let base-section = 0.3cm

// Strip links entirely for the no-links variant, otherwise render as a
// normal (colored, underlined) hyperlink.
#let clink(url, body) = if no-links { body } else { link(url)[#underline(text(fill: blue, body))] }

// The whole document body, parameterised by the spacing scale factor `k`.
// Height is linear in `k` (line count is fixed; only gaps grow), so two
// measurements pin down the `k` that fills the page — see the layout block below.
#let cv-body(k) = [
  #set par(justify: false, leading: k * base-leading, spacing: 0.4em)
  #set list(marker: [•], indent: 0pt, body-indent: 8pt, tight: false, spacing: k * base-list)

  #let entryspacing = k * base-entry

  #let section(title) = {
    v(k * base-section)
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

  #section[Education]

  #cventry(
    [2024--Present],
    [*University of Manchester*, PhD in Computer Science],
  )[
    - Research focused on formal verification of degraded systems.
    - Supervised by #clink("https://mariefarrell.github.io/", "Dr. Marie Farrell"), #clink("https://personalpages.manchester.ac.uk/staff/louise.dennis/", "Prof. Louise Dennis"), and #clink("https://personalpages.manchester.ac.uk/staff/michael.fisher/", "Prof. Michael Fisher").
  ]

  #v(entryspacing)

  #cventry(
    [2019--2022],
    [*University of Cambridge*, BA (Hons) in Computer Science],
  )[
    - Grade II.1 (70%).
    - Dissertation titled _Delay-Tolerant Link-State Routing_. Implemented and empirically evaluated a failure-tolerant routing protocol in C to run on real Unix-based routers, comparing it against traditional protocols. Supervised by #clink("https://jacksonwoodruff.com/", "Dr. Jackson Woodruff").
  ]

  #section[Publications]

  - #cventry(
    [2026],
    [*Counterexample-Guided Interval Weakening*],
  )[
    _Andrew, B. M., Dennis, L. A., Fisher, M., Farrell, M._, ABZ 2026, #clink("https://doi.org/10.1007/978-3-032-26752-8_1", "paper")
  ]

  #v(entryspacing)

  - #cventry(
    [2025],
    [*Weakening Goals in Logical Specifications*],
  )[
    _Andrew, B. M._, ABZ 2025, #clink("https://doi.org/10.1007/978-3-031-94533-5_22", "paper")
  ]

  #section[Industry Experience]

  #cventry(
    [2022--2024],
    [*Software Engineer*, Tarides -- Paris, France],
  )[
    - Built open-source CI infrastructure for the OCaml ecosystem, distributing dependency solving, compilation, and testing across a broad matrix of operating systems, CPU architectures, and compiler versions.
    - Tested tens of thousands of packages across the Opam Repository, OCaml's central package universe.
    - Exposed concrete bugs in the OCaml 5 multicore runtime through systematic stress-testing, reporting and tracking them to resolution upstream.
  ]

  #v(entryspacing)

  #cventry(
    [2021],
    [*Embedded Systems Intern*, Tarides -- Paris, France],
  )[
    - Cross-compiled the OCaml bytecode runtime to an ARM-based microcontroller running a real-time operating system, as part of an R\&D project.
  ]

  #v(entryspacing)

  #cventry(
    [2020],
    [*Computer Graphics Research Intern*, University of Cambridge],
  )[
    - Developed and implemented a visual model of ageing vision in virtual reality with Unity, as part of the Graphics and Displays Research Group.
  ]

  #section[Teaching Experience]

  #cventry(
    [2022--Present],
    [*University of Cambridge*, Supervisor (TA equiv.)],
  )[
    - Leading small group supervisions for undergraduate courses in computer science, including topics such as logic, formal verification, and semantics of programming languages.
  ]

  #v(entryspacing)

  #cventry(
    [2024--2026],
    [*University of Manchester*, Graduate Teaching Assistant],
  )[
    - Assisted in teaching graduate and undergraduate courses in computer science, including topics such as software engineering, logic, and formal verification.
  ]

  #section[Skills]

  *Topics:* Research, Computer Science, Mathematics, Systems Programming, Formal Verification, Software Engineering

  #v(entryspacing)

  *Programming:* AI-assisted programming, C, C++, OCaml, Python, Rust, HTML, CSS, Bash, Git, Docker

  #v(entryspacing)

  *Languages:* English, French
]

#if for-website [
  #place(top + right, dy: -1cm)[
    #text(size: 8pt, fill: gray, style: "italic")[Last updated on Jun 27th, 2026]
  ]
]

// Solve for the spacing scale `k` that makes the body fill exactly one page.
// Body height is affine in k: N(k) = base + k * p. Measure at k = 1 and k = 2,
// recover base and p, then choose k so N(k) equals the available height (less a
// small safety margin). Clamp k >= 1 so we never compress below the natural
// spacing — if the content overflows, it simply spills to a second page.
#context layout(size => {
  let natural-height(k) = measure(box(width: size.width, cv-body(k))).height
  let n1 = natural-height(1)
  let n2 = natural-height(2)
  let p = n2 - n1
  let base = n1 - p
  let k = calc.max(1.0, (size.height - base - 2pt) / p)
  cv-body(k)
})
