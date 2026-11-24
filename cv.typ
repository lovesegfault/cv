// PDF renderer. Compile with: typst compile cv.typ build/cv.pdf
//
// Deliberately a single column with standard section names, so that applicant
// tracking systems extract it in reading order.
#import "@preview/basic-resume:0.2.9": edu, resume, work
#import "content.typ" as cv

#let max-pages = 2
#let footer = context {
  let pages = counter(page).final().first()
  // Fail the build rather than silently spilling onto another page.
  assert(
    pages <= max-pages,
    message: "CV is " + str(pages) + " pages, the limit is " + str(max-pages),
  )
  set text(size: 7.5pt, fill: rgb("#55606a"))
  cv.name
  h(0.45em)
  sym.dot.c
  h(0.45em)
  datetime.today().display("[month repr:long] [year]")
  h(0.45em)
  sym.dot.c
  h(0.45em)
  link(cv.source-url)[source]
  h(1fr)
  counter(page).display("1 / 1", both: true)
}

// This must come before the resume show rule: changing page properties after
// the template has laid out the header would force a page break.
#set page(footer: footer)

#show: resume.with(
  author: cv.name,
  // basic-resume has no dedicated position field; pronouns is rendered as the
  // first plain-text item of the contact line, which is exactly where the
  // position belongs. Check the contact line after any basic-resume bump in
  // case upstream restyles how pronouns are rendered.
  pronouns: cv.position,
  location: cv.location,
  email: cv.email,
  phone: cv.phone,
  personal-site: cv.website,
  github: cv.github,
  accent-color: "#000000",
  font: "Libertinus Serif",
  paper: "us-letter",
  author-position: center,
  personal-info-position: center,
)
// The template justifies, which can squeeze spaces until text extractors no
// longer see them.
#set par(justify: false)

// Dates go inline: text extractors can move right-aligned ones into the
// neighboring entry.
#let with-dates(body, entry) = [#body | #cv.date-range(entry.start, entry.end)]

== Summary

#cv.summary

== Experience

#for employer in cv.experience {
  for role in employer.roles {
    // work() is inline, so the block keeps a role with no bullets from running
    // into the next one, as well as keeping each role on a single page.
    block(breakable: false, {
      work(
        title: role.title,
        company: with-dates(
          // The wider space keeps "Amazon Web" two words when extracted.
          text(weight: "semibold", spacing: 120%, employer.company),
          role,
        ),
      )
      if role.bullets.len() > 0 { list(..role.bullets) }
    })
  }
}

== Open Source Projects

#for proj in cv.projects [
  - #link(proj.url)[*#proj.name*]*:* #proj.description
]

== Skills

#for skill in cv.skills [
  - *#skill.category:* #skill.items
]

== Talks & Writing

#for talk in cv.talks [
  - *Talk:* #talk.title, #talk.venue
    (#talk.links.map(l => link(l.url, l.label)).join(", "))
]
- *Posts:* #cv.writing.map(w => link(w.url, w.title)).join("; ")
#for piece in cv.translations [
  - *Translation:* #link(piece.url, piece.title), #piece.note
]

== Education

#for school in cv.education {
  edu(
    institution: school.institution,
    degree: with-dates(school.degree, school),
    consistent: true,
  )
  list([*Selected classes:* #school.classes.join(", ")])
}

== Volunteering & Interests

#for vol in cv.volunteering [
  - #if vol.url != none [#link(vol.url)[*#vol.name*]] else [*#vol.name*]*:*
    #vol.description
]
- *Interests:* #cv.interests
