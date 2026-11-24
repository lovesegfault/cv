// All CV content and shared values live here, used by both the PDF (cv.typ)
// and HTML (cv-html.typ) renderers. Anything rendered by both belongs here.

#let name = "Bernardo Meurer Costa"
#let position = "Software Engineer"
#let location = "Brooklyn, New York"
#let email = "bernardo@meurer.org"
#let phone = "(805) 886-1045"
#let website = "lovesegfault.com"
#let github = "github.com/lovesegfault"
#let accent-color = "#00696b"
#let source-url = "https://github.com/lovesegfault/cv"
#let photo = "images/profilpicture.jpg"

#let date-range(start, end) = start + "–" + end

#let summary = [Rust expert and systems engineer with 8+ years shipping
  high-performance production software, now working on reinforcement learning
  infrastructure at Anthropic. Previously led all Rust developer experience at
  AWS (4,000+ developers). Experienced in build systems, compilers, operating
  systems, hardware, and computer vision. Nix team member and nixpkgs maintainer
  who brings Rust to teams and large codebases, root-causes hard-to-reproduce
  failures, and communicates with candor and compassion.]

#let experience = (
  (
    company: "Anthropic",
    roles: (
      (
        title: "Member of Technical Staff, Reinforcement Learning",
        start: "2026",
        end: "Present",
        bullets: ([Working on reinforcement learning (RL) infrastructure.],),
      ),
      (
        title: "Member of Technical Staff, Developer Platform",
        start: "2025",
        end: "2026",
        bullets: (
          [Worked on Nix remote build infrastructure, delivering fast,
            reproducible builds at company scale for engineering and research.],
        ),
      ),
    ),
  ),
  (
    company: "Amazon Web Services (AWS)",
    roles: (
      (
        title: "Senior Software Development Engineer (SDE III)",
        start: "2023",
        end: "2025",
        bullets: (
          [Drove improvements to the Rust developer experience at Amazon that
            saved hundreds of millions of dollars in engineering time and build
            infrastructure costs.],
          [Led all Rust developer experience at AWS (Builder Tools Language
            Experience team), serving over 4,000 developers.],
          [Worked closely with the Rust compiler team as the liaison between
            open-source Rust and Amazon's business needs.],
          [As the only team member remaining after layoffs, took on the load
            previously shared by about five senior engineers.],
        ),
      ),
      (
        title: "Software Development Engineer II (SDE II)",
        start: "2022",
        end: "2023",
        bullets: (
          [Owned all of CargoBrazil, the integration between Cargo and Amazon's
            internal build system (Brazil).],
          [Ran weekly Nix office hours, helping hundreds of developers become
            productive with Nix.],
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
          [Worked on QKernel, the quantum computer's operating system and
            control software, and on QCC, its circuit compiler.],
          [Led the effort to port core components to Rust, and automated the
            translation of SystemVerilog headers into Rust.],
          [Cut CI times from about 40 minutes to 10 or less, and implemented
            self-hosted GitHub Actions on GKE for over 100 engineers.],
          [Helped trace root causes and draft fixes in multiple complex
            incident responses.],
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
          [Built the software operating every camera at every site, feeding
            over 100 Gb/s of image data to ML models, all processed on-site.],
          [Built and deployed Neobuffer, providing safe, lock-free,
            cross-process channels in Rust.],
          [Helped bring Rust to all of engineering, from my initial 2,000-line
            project to almost 60,000 lines company-wide.],
          [Helped migrate data pipelines from Python to Rust, eliminating years
            of technical debt.],
          [Spearheaded company-wide data requirements gathering, then worked on
            the internal data engineering tools it grew into.],
          [Debugged camera hardware faults and worked with the vendor to
            develop and deploy fixes.],
          [Implemented an engineering-wide request for comments (RFC) process.],
          [Helped review an acquisition, assessing the target company's stack
            for integration and licensing risks.],
        ),
      ),
    ),
  ),
  (
    company: "Hangar",
    roles: (
      (
        title: "Co-founder",
        start: "2015",
        end: "2018",
        bullets: (
          [Helped grow one of Brazil's first makerspaces from 3 to over 30
            members and held workshops on C, robotics, and Rust.],
        ),
      ),
    ),
  ),
  (
    company: "Async Open Source",
    roles: (
      (
        title: "Summer Intern",
        start: "2014",
        end: "2016",
        bullets: (
          [Developed a tool for migrating customer databases to Postgres,
            ported the company's application to mobile with Cordova, and helped
            triage and fix bugs in its use of PyGTK.],
        ),
      ),
    ),
  ),
)

#let projects = (
  (
    name: "Nix",
    url: "https://github.com/NixOS/nix",
    description: [Member of the Nix team and of the team that packages Nix in
      nixpkgs],
  ),
  (
    name: "nixpkgs",
    url: "https://github.com/NixOS/nixpkgs",
    description: [Maintain 60+ packages, including binutils, parts of the ROCm
      stack, libvirt, Thunderbird, and firefox-bin],
  ),
  (
    name: "beautysh",
    url: "https://github.com/lovesegfault/beautysh",
    description: [Bash formatter],
  ),
  (
    name: "transcode-rs",
    url: "https://github.com/lovesegfault/transcode-rs",
    description: [Rust utility to discover, analyze, and transcode video
      collections to AV1],
  ),
  (
    name: "cache-size",
    url: "https://github.com/lovesegfault/cache-size",
    description: [Rust crate for querying CPU cache sizes],
  ),
  (
    name: "nix-config",
    url: "https://github.com/lovesegfault/nix-config",
    description: [NixOS configuration spanning all my systems],
  ),
  (
    name: "genesis",
    url: "https://github.com/lovesegfault/genesis",
    description: [Explorations into genetic algorithms],
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

#let skills = (
  (
    category: "Programming",
    items: [Rust (expert), Nix, Python, C, C++, Bash, VHDL, LaTeX],
  ),
  (
    category: "Infrastructure",
    items: [Linux, NixOS, GitHub Actions, Google Kubernetes Engine (GKE)],
  ),
  (
    category: "Libraries",
    items: [Tokio, nalgebra, OpenCV, GStreamer, FFmpeg, Aravis, NumPy, pandas],
  ),
  (category: "Tools", items: [Git, Cargo, Meson, Portage, Vivado]),
  (
    category: "Spoken languages",
    items: [Portuguese (native), English (fluent), Spanish and French
      (beginner)],
  ),
)

#let talks = (
  (
    title: [The Missing Part of Nix (and Where to Find It)],
    venue: "Planet Nix 2026",
    links: (
      (label: "recording", url: "https://www.youtube.com/watch?v=wewEPigb2o0"),
      (
        label: "abstract",
        url: "https://www.socallinuxexpo.org/scale/23x/presentations/missing-part-nix-and-where-find-it",
      ),
    ),
  ),
  (
    title: [Neobuffer: Safe, Lock-Free, Cross-Process Channels in Rust],
    venue: "RustLab 2019",
    links: (
      (label: "recording", url: "https://www.youtube.com/watch?v=3NVev3FhGgk"),
      (
        label: "slides",
        url: "https://lovesegfault.com/slides/rustlab-2019.pdf",
      ),
    ),
  ),
)

#let writing = (
  (
    title: "C Arrays Are Not Pointers",
    url: "https://lovesegfault.com/posts/c-arrays-are-not-pointers/",
  ),
  (
    title: "Notes on Euclidean Spaces",
    url: "https://lovesegfault.com/posts/notes-on-euclidean-spaces/",
  ),
  (
    title: "On Leibniz’s Truth",
    url: "https://lovesegfault.com/posts/on-leibniz-truth/",
  ),
  (
    title: "DRM Is Anti-Copyright",
    url: "https://lovesegfault.com/posts/drm-is-anti-copyright/",
  ),
)

// Work by others that I contributed to; keep it apart from my own writing.
#let translations = (
  (
    title: "Swing, divide and conquer the factorial",
    url: "https://oeis.org/A000142/a000142.pdf",
    note: [by Peter Luschny; helped translate from German],
  ),
)

#let education = (
  (
    institution: "Instituto Superior Técnico",
    degree: "Coursework in Computer Engineering",
    start: "2016",
    end: "2018",
    classes: (
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

#let volunteering = (
  (
    name: "Take to the Hills",
    url: "https://taketothehills.net/",
    description: [Helped maintain Berkeley's trails and their native plants],
  ),
  (
    name: "PECEP",
    url: "http://pecep.educacao.ws/",
    description: [Taught mathematics to high school students from Rio's
      Rocinha favela],
  ),
  (
    name: "CS50 Brazil",
    url: none,
    description: [Teaching assistant for a recreation of Harvard's CS50 in Rio
      de Janeiro],
  ),
)

#let interests = [3D printing, radio and amplifier electronics, botany and
  taxonomy]
