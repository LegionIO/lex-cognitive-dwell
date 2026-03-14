# frozen_string_literal: true

require_relative 'lib/legion/extensions/cognitive_dwell/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-cognitive-dwell'
  spec.version       = Legion::Extensions::CognitiveDwell::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'Cognitive dwell time modeling for LegionIO'
  spec.description   = 'Models how long the system lingers on topics based on salience, novelty, emotional ' \
                        'intensity, and complexity. Detects sticky topics and rumination.'
  spec.homepage      = 'https://github.com/LegionIO/lex-cognitive-dwell'
  spec.license       = 'MIT'

  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri']      = spec.homepage
  spec.metadata['source_code_uri']   = 'https://github.com/LegionIO/lex-cognitive-dwell'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-cognitive-dwell/blob/master/README.md'
  spec.metadata['changelog_uri']     = 'https://github.com/LegionIO/lex-cognitive-dwell/blob/master/CHANGELOG.md'
  spec.metadata['bug_tracker_uri']   = 'https://github.com/LegionIO/lex-cognitive-dwell/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ['lib']
end
