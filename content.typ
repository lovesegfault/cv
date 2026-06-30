// All CV content and shared values live here, used by both the PDF (cv.typ)
// and HTML (cv-html.typ) renderers. Anything rendered by both belongs here.

#let name = "Bernardo Meurer Costa"
#let position = "Software Engineer"
#let location = "Brooklyn, New York"
#let email = "bernardo@meurer.org"
#let phone = "(805) 886-1045"
#let linkedin = "linkedin.com/in/meurerbernardo"
#let github = "github.com/lovesegfault"
#let accent-color = "#008080"
#let source-url = "https://github.com/lovesegfault/cv"
#let photo = "images/profilpicture.jpg"

#let date-range(start, end) = start + " — " + end

#let glance = (
  [8+ years experience writing and deploying high-performance systems into
    production with Rust.],
  [Diverse breadth of experience, having worked on driving hardware devices,
    compilers, build systems, operating systems, and computer vision.],
  [Proven track record of debugging hard-to-reproduce hardware/software issues
    and communicating root causes and solutions effectively.],
  [Extensive experience porting large codebases to Rust and introducing Rust
    to teams.],
  [Strong communication skills, taking pride in speaking to others with candor
    and compassion.],
)

#let experience = (
  (
    company: "Anthropic",
    roles: (
      (
        title: "Member of Technical Staff",
        start: "2025",
        end: "Present",
        bullets: (
          [Work on the Developer Platform team, which owns the build and
            developer infrastructure powering Anthropic's engineering and
            research organizations.],
          [Focus on Nix remote build infrastructure, delivering fast,
            reproducible builds at company scale.],
        ),
      ),
    ),
  ),
  (
    company: "AWS",
    roles: (
      (
        title: "SDE III",
        start: "2023",
        end: "2025",
        bullets: (
          [Lead developer for the BTLX (Builder Tools Language Experience)
            Rust team, in charge of the experience of over 4000 developers
            using Rust at AWS.],
          [Sole team member to survive the wave of layoffs, taking on the load
            that was previously shared by a team of ≈ 5 senior engineers.],
          [Worked closely with the Rust compiler team, acting as the
            intermediary between Open Source and business needs of Rust at
            Amazon.],
          [Drove various improvements to the Rust experience at Amazon,
            leading to many billions of dollars saved in engineering time and
            build infrastructure costs.],
        ),
      ),
      (
        title: "SDE II",
        start: "2022",
        end: "2023",
        bullets: (
          [Worked on CargoBrazil, the integration between Cargo and Amazon's
            internal build system, Brazil.],
          [Held the weekly Nix office hours, helping hundreds of developers
            become productive with Nix in the process.],
        ),
      ),
    ),
  ),
  (
    company: "Google Quantum AI",
    roles: (
      (
        title: "Software Engineer",
        start: "2021",
        end: "2022",
        bullets: (
          [Worked on QKernel, the operating system and control software for
            the quantum computer.],
          [Worked on QCC, the quantum circuit compiler.],
          [Lead the effort to port core components to Rust.],
          [Participated in multiple complex incident responses, helping trace
            root causes and draft solutions.],
          [Brought CI times from ≈ 40 minutes to ≲ 10 minutes.],
          [Implemented self-hosted GitHub Actions for a team of over 100
            engineers using GKE.],
          [Automated the translation of SystemVerilog headers into Rust.],
        ),
      ),
    ),
  ),
  (
    company: "Standard Cognition",
    roles: (
      (
        title: "AI Systems Software Engineer",
        start: "2018",
        end: "2021",
        bullets: (
          [Initially worked on the camera and imaging stack, where I built the
            software that operates all cameras across their sites, managing
            upwards of 100Gb/s of image data with only on-site processing.],
          [Transitioned into helping migrate data pipeline code from Python to
            Rust, eliminating years of technical debt.],
          [Spearheaded a company-wide requirements gathering in order to
            understand our data needs. This evolved into a project to create
            better internal data engineering tools, which I worked on until
            2020.],
          [Helped review the acquisition of another company, where I was
            responsible for analyzing their stack and detecting possible
            issues during integration, as well as licensing issues.],
          [Implemented a successful engineering-wide RFC process.],
          [Debugged numerous hardware issues with cameras and worked with the
            vendor on developing and deploying fixes.],
          [Helped bring Rust to the entire engineering team, taking us from my
            initial ∼ 2000 LoC project to almost 60 000 lines of Rust
            company-wide.],
        ),
      ),
    ),
  ),
  (
    company: "Hangar",
    roles: (
      (
        title: "Founder",
        start: "2015",
        end: "2018",
        bullets: (
          [Co-founded Hangar, one of the first makerspaces in Brazil.],
          [Helped grow the organization from 3 to over 30 members.],
          [Held workshops on C, robotics, and Rust.],
        ),
      ),
    ),
  ),
  (
    company: "Async Open Source",
    roles: (
      (
        title: "Intern",
        start: "2014",
        end: "2016 Summers",
        bullets: (
          [Developed an application that helped customers easily migrate their
            databases to Postgres.],
          [Migrated our application to mobile using Cordova.],
          [Helped fix and triage many bugs in our usage of PyGTK.],
        ),
      ),
    ),
  ),
)

#let skills = (
  (
    category: "Programming Languages",
    items: [*Experienced:* Rust, C, Nix, Bash.
      *Familiar:* Python, C++, VHDL, LaTeX.],
  ),
  (
    category: "Languages",
    items: [*Native:* Portuguese. *Fluent:* English.
      *Beginner:* Spanish, French.],
  ),
  (
    category: "Libraries",
    items: [OpenCV, Gstreamer, FFmpeg, numpy, pandas, tokio, Aravis,
      nalgebra.],
  ),
  (
    category: "Tools",
    items: [Linux, Git, Nix, Cargo, Vim, Vivado, Meson, Portage.],
  ),
)

#let projects = (
  (
    name: "nixpkgs",
    url: "https://github.com/NixOS/nixpkgs",
    description: [Maintain binutils, firefox, thunderbird, beets, bindfs, and
      more],
  ),
  (
    name: "nix-config",
    url: "https://github.com/lovesegfault/nix-config",
    description: [My NixOS configuration spanning all my systems],
  ),
  (
    name: "genesis",
    url: "https://github.com/lovesegfault/genesis",
    description: [Explorations into genetic algorithms],
  ),
  (
    name: "transcode-rs",
    url: "https://github.com/lovesegfault/transcode-rs",
    description: [Rust utility to discover, analyze, and transcode a video
      collection to AV1],
  ),
  (
    name: "beautysh",
    url: "https://github.com/lovesegfault/beautysh",
    description: [Bash formatter],
  ),
  (
    name: "cache-size",
    url: "https://github.com/lovesegfault/cache-size",
    description: [Simple Rust crate to get the CPU cache sizes],
  ),
  (
    name: "daedalos",
    url: "https://github.com/lovesegfault/daedalos",
    description: [Rust kernel based on the osdev wiki],
  ),
  (
    name: "hyperpixel-init",
    url: "https://github.com/lovesegfault/hyperpixel-init",
    description: [Configures and initializes the Hyperpixel 4 display,
      allowing you to use it without loading dtbs],
  ),
  (
    name: "cv",
    url: "https://github.com/lovesegfault/cv",
    description: [This very CV],
  ),
)

#let talks = (
  (
    title: [RustLab 2019 --- Neobuffer: Safe, Lock Free, Cross-Process
      Channels in Rust],
    links: (
      (label: "Recording", url: "https://www.youtube.com/watch?v=3NVev3FhGgk"),
      (
        label: "Slides",
        url: "https://lovesegfault.com/slides/rustlab-2019.pdf",
      ),
    ),
  ),
)

#let education = (
  (
    institution: "Instituto Superior Técnico",
    degree: "Coursework in Computer Engineering",
    start: "2016",
    end: "2018",
    coursework: (
      "Digital Systems",
      "Computer Architecture",
      "Programming (C)",
      "Linear Algebra",
      "Applied Chemistry",
      "Real Analysis",
      "Multivariable Calculus",
      "Mechanics & Waves",
      "Management of Engineering Projects",
    ),
  ),
)

#let writing = (
  (
    title: "Notes on Euclidean Spaces",
    url: "https://lovesegfault.com/posts/notes-on-euclidean-spaces/",
  ),
  (
    title: "C Arrays Are Not Pointers",
    url: "https://lovesegfault.com/posts/c-arrays-are-not-pointers/",
  ),
  (
    title: "DRM Is Anti-Copyright",
    url: "https://lovesegfault.com/posts/drm-is-anti-copyright/",
  ),
  (
    title: "On Leibniz's Truth",
    url: "https://lovesegfault.com/posts/on-leibniz-truth/",
  ),
  (
    title: "Swing, divide and conquer the factorial",
    url: "https://oeis.org/A000142/a000142.pdf",
  ),
)

#let hobbies = (
  [3D printing],
  [Electronics (mostly radio and amplifier construction)],
  [Botany / Taxonomy],
)

#let volunteering = (
  (
    name: "Take to the Hills",
    url: "https://taketothehills.net/",
    description: [Help maintain the Berkeley trails, cleaning them and keeping
      them filled with beautiful California native plants.],
  ),
  (
    name: "PECEP",
    url: "http://pecep.educacao.ws/",
    description: [Taught mathematics to high school students from the Rocinha
      favela of Rio.],
  ),
  (
    name: "CS50 Brazil",
    url: none,
    description: [Was a TA during a recreation of the Harvard CS50 course in
      Rio de Janeiro.],
  ),
)
