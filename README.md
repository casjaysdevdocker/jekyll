# Jekyll Docker Container with GitHub Pages Support

Docker container for Jekyll static site generator with full GitHub Pages support.

## Features

- Based on Ruby 3.3 Alpine
- Jekyll with latest stable version
- Full GitHub Pages gem support
- Bundler for dependency management
- WEBrick for local serving
- Multi-architecture support (amd64, arm64)

## Usage

### Run Jekyll Server

```bash
docker run -d \
  -p 4000:4000 \
  -v $(pwd):/srv/jekyll \
  casjaysdevdocker/jekyll
```

### Create New Site

```bash
docker run --rm \
  -v $(pwd):/srv/jekyll \
  casjaysdevdocker/jekyll \
  jekyll new my-site
```

### Build Site

```bash
docker run --rm \
  -v $(pwd):/srv/jekyll \
  casjaysdevdocker/jekyll \
  jekyll build
```

### Serve with Live Reload

```bash
docker run -d \
  -p 4000:4000 \
  -v $(pwd):/srv/jekyll \
  casjaysdevdocker/jekyll \
  jekyll serve --host 0.0.0.0 --livereload
```

## Environment Variables

- `LANG_VERSION` - Jekyll version (default: latest)
- `SERVICE_PORT` - Port to expose (default: 4000)

## Volumes

- `/srv/jekyll` - Jekyll site directory
- `/usr/local/share/template-files` - Template files

## Ports

- `4000` - Jekyll development server

## GitHub Pages

This container includes the `github-pages` gem which ensures compatibility with GitHub Pages deployment.

## License

MIT - CasjaysDev
