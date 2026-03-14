# lex-cognitive-dwell

Cognitive dwell time modeling for LegionIO. Models how long the system lingers on topics based on salience, novelty, emotional intensity, and complexity. Detects sticky topics and rumination.

## What It Does

Not all topics receive equal attention. This extension models dwell time — how long a topic captures cognitive focus — as a weighted function of salience, novelty, emotional intensity, and complexity. Topics with high emotional intensity (weight 0.3) attract the most attention; salience and novelty each contribute equally (0.25); complexity adds a smaller pull (0.2). Dwell decays over time unless actively reinforced by focus.

Three critical thresholds: sticky (0.7, noteworthy persistence), and rumination (0.9, unhealthy fixation requiring intervention).

## Usage

```ruby
client = Legion::Extensions::CognitiveDwell::Client.new

topic = client.add_topic(
  content: 'unresolved question about consent tier promotion criteria',
  topic_type: :problem,
  salience: 0.8,
  novelty: 0.6,
  emotional_intensity: 0.7,
  complexity: 0.5
)

client.focus_on(topic_id: topic[:topic][:id])
client.sticky_topics
client.ruminating_topics

client.decay   # call each tick
client.dwell_report
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
