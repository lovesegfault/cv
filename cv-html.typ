// HTML renderer. Compile with:
//   typst compile --features html --format html cv-html.typ build/cv.html
#import "content.typ" as cv

// The manual <html>/<head>/<body> skeleton below suppresses typst's
// auto-generated head, so document metadata is emitted there directly.
#let css = (
  "
:root {
  --accent: "
    + cv.accent-color
    + ";
  --fg: #1f2933;
  --fg-soft: #52606d;
  --bg: #ffffff;
  --rule: #d3dce3;
}
@media (prefers-color-scheme: dark) {
  :root {
    --accent: #4cc9c0;
    --fg: #e4e7eb;
    --fg-soft: #9aa5b1;
    --bg: #15191e;
    --rule: #323f4b;
  }
}
* { box-sizing: border-box; }
body {
  margin: 0 auto;
  padding: 2.5rem 1.25rem 1rem;
  max-width: 46rem;
  font-family: Georgia, 'Times New Roman', serif;
  font-size: 1rem;
  line-height: 1.55;
  color: var(--fg);
  background: var(--bg);
}
a { color: var(--accent); }
header { display: flex; align-items: center; gap: 1.5rem; flex-wrap: wrap; }
header img {
  width: 7.5rem;
  height: 7.5rem;
  border-radius: 50%;
  object-fit: cover;
}
h1 { margin: 0; font-size: 2rem; color: var(--accent); }
.position { margin: 0.15rem 0 0.4rem; font-size: 1.15rem; color: var(--fg-soft); }
.contact { margin: 0; padding: 0; list-style: none; font-size: 0.9rem; }
.contact li { display: inline; }
.contact li + li::before { content: ' | '; color: var(--fg-soft); }
h2 {
  margin: 1.75rem 0 0.5rem;
  font-size: 1.2rem;
  font-variant: small-caps;
  letter-spacing: 0.04em;
  color: var(--accent);
  border-bottom: 1px solid var(--rule);
}
h3 { margin: 1rem 0 0; font-size: 1rem; }
.role {
  display: flex;
  justify-content: space-between;
  align-items: baseline;
  gap: 1rem;
  flex-wrap: wrap;
}
.role .dates { color: var(--fg-soft); font-style: italic; white-space: nowrap; }
.company { margin: 0; color: var(--fg-soft); }
ul { margin: 0.3rem 0 0.75rem; padding-left: 1.4rem; }
li { margin: 0.15rem 0; }
footer {
  margin-top: 2.5rem;
  padding-top: 0.5rem;
  border-top: 1px solid var(--rule);
  font-size: 0.8rem;
  color: var(--fg-soft);
}
"
)

#html.elem("html", attrs: (lang: "en"))[
  #html.elem("head")[
    #html.elem("meta", attrs: (charset: "utf-8"))
    #html.elem(
      "meta",
      attrs: (name: "viewport", content: "width=device-width, initial-scale=1"),
    )
    #html.elem("title")[#cv.name]
    #html.elem(
      "meta",
      attrs: (name: "description", content: cv.name + " — " + cv.position),
    )
    #html.elem("style", css)
  ]
  #html.elem("body")[
    #html.elem("header")[
      #image(cv.photo, alt: "Portrait of " + cv.name)
      #html.elem("div")[
        #html.elem("h1")[#cv.name]
        #html.elem("p", attrs: (class: "position"))[#cv.position]
        #html.elem("ul", attrs: (class: "contact"))[
          #html.elem("li")[#cv.location]
          #html.elem("li")[#link("mailto:" + cv.email)[#cv.email]]
          #html.elem("li")[#cv.phone]
          #html.elem("li")[#link("https://" + cv.linkedin)[linkedin]]
          #html.elem("li")[#link("https://" + cv.github)[github]]
        ]
      ]
    ]
    #html.elem("main")[
      = At a Glance
      #list(..cv.glance)

      = Experience
      #for employer in cv.experience {
        for role in employer.roles {
          html.elem("div", attrs: (class: "role"))[
            #html.elem("h3")[#role.title]
            #html.elem("span", attrs: (class: "dates"))[
              #cv.date-range(role.start, role.end)
            ]
          ]
          html.elem("p", attrs: (class: "company"))[#employer.company]
          list(..role.bullets)
        }
      }

      = Skills
      #for skill in cv.skills [
        - *#skill.category*: #skill.items
      ]

      = Open-Source Projects
      #for proj in cv.projects [
        - #link(proj.url)[#proj.name] --- #proj.description
      ]

      = Talks
      #for talk in cv.talks [
        - #talk.title
          (#talk.links.map(l => link(l.url)[#l.label]).join[ | ])
      ]

      = Education
      #for school in cv.education {
        html.elem("div", attrs: (class: "role"))[
          #html.elem("h3")[#school.institution]
          #html.elem("span", attrs: (class: "dates"))[
            #cv.date-range(school.start, school.end)
          ]
        ]
        html.elem("p", attrs: (class: "company"))[#school.degree]
        list([Relevant coursework: #school.coursework.join(", ").])
      }

      = Writing
      #for piece in cv.writing [
        - #link(piece.url)[#piece.title]
      ]

      = Hobbies
      #list(..cv.hobbies)

      = Volunteering
      #for vol in cv.volunteering [
        - #if vol.url != none [#link(vol.url)[#vol.name]] else [#vol.name] ---
          #vol.description
      ]
    ]
    #html.elem("footer")[
      #context datetime.today().display("[month repr:long] [day], [year]") /
      #link(cv.source-url)[source code]
    ]
  ]
]
