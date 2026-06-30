// PDF renderer. Compile with: typst compile cv.typ build/cv.pdf
#import "@preview/basic-resume:0.2.9": *
#import "content.typ" as cv

// This must come before the resume show rule: changing page properties after
// the template has already laid out the header would force a page break.
#set page(
  footer: context [
    #set text(size: 7pt, fill: gray)
    #datetime.today().display("[month repr:long] [day], [year]") /
    #link(cv.source-url)[source code]
  ],
)

#show: resume.with(
  author: cv.name,
  // basic-resume has no dedicated position field; pronouns is rendered as the
  // first plain-text item of the contact line, which is exactly where the
  // position belongs. Check the contact line after any basic-resume bump in
  // case upstream restyles how pronouns are rendered.
  pronouns: cv.position,
  location: cv.location,
  email: cv.email,
  github: cv.github,
  linkedin: cv.linkedin,
  phone: cv.phone,
  accent-color: cv.accent-color,
  paper: "us-letter",
)

== At a Glance

#list(..cv.glance)

== Experience

#for employer in cv.experience {
  for role in employer.roles {
    work(
      title: role.title,
      company: employer.company,
      dates: cv.date-range(role.start, role.end),
    )
    list(..role.bullets)
  }
}

== Skills

#for skill in cv.skills [
  - *#skill.category*: #skill.items
]

== Open-Source Projects

#for proj in cv.projects [
  - #link(proj.url)[#proj.name] --- #proj.description
]

== Talks

#for talk in cv.talks [
  - #talk.title #h(1fr) #talk.links.map(l => link(l.url)[#l.label]).join[ | ]
]

== Education

#for school in cv.education {
  edu(
    institution: school.institution,
    degree: school.degree,
    dates: cv.date-range(school.start, school.end),
    consistent: true,
  )
  list([Relevant coursework: #school.coursework.join(", ").])
}

== Writing

#for piece in cv.writing [
  - #link(piece.url)[#piece.title]
]

== Hobbies

#list(..cv.hobbies)

== Volunteering

#for vol in cv.volunteering [
  - #if vol.url != none [#link(vol.url)[#vol.name]] else [#vol.name] ---
    #vol.description
]
