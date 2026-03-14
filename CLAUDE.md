# lex-cognitive-dwell

**Level 3 Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`
- **Grandparent**: `/Users/miverso2/rubymine/legion/CLAUDE.md`

## Purpose

Models how long the system lingers on topics based on salience, novelty, emotional intensity, and complexity. Detects sticky topics and rumination. Provides attention-as-duration modeling: some topics naturally attract longer dwell times; others are fleeting. Rumination is detected when dwell time reaches critical levels.

## Gem Info

- **Gem name**: `lex-cognitive-dwell`
- **Version**: `0.1.0`
- **Module**: `Legion::Extensions::CognitiveDwell`
- **Ruby**: `>= 3.4`
- **License**: MIT

## File Structure

```
lib/legion/extensions/cognitive_dwell/
  cognitive_dwell.rb
  version.rb
  client.rb
  helpers/
    constants.rb
    dwell_engine.rb
    dwell_topic.rb
  runners/
    cognitive_dwell.rb
```

## Key Constants

From `helpers/constants.rb`:

- `TOPIC_TYPES` — `%i[problem concept conversation task memory emotion plan decision observation]`
- `MAX_TOPICS` = `200`, `MAX_DWELL_HISTORY` = `500`
- `BASE_DWELL` = `0.3`
- Dwell score weights: `SALIENCE_WEIGHT` = `0.25`, `NOVELTY_WEIGHT` = `0.25`, `EMOTION_WEIGHT` = `0.3`, `COMPLEXITY_WEIGHT` = `0.2`
- `DWELL_DECAY` = `0.05`, `ENGAGEMENT_BOOST` = `0.08`
- `STICKY_THRESHOLD` = `0.7`, `FLEETING_THRESHOLD` = `0.2`, `RUMINATION_THRESHOLD` = `0.9`
- `DWELL_LABELS` — `0.8+` = `:stuck`, `0.6` = `:engrossed`, `0.4` = `:attending`, `0.2` = `:browsing`, below = `:fleeting`
- `ENGAGEMENT_LABELS` — `0.8+` = `:deeply_engaged` through below `0.2` = `:disengaged`
- `DISENGAGE_LABELS` — `0.8+` = `:very_hard` through below `0.2` = `:effortless`

## Runners

All methods in `Runners::CognitiveDwell`:

- `add_topic(content:, topic_type: :concept, salience: 0.5, novelty: 0.5, emotional_intensity: 0.3, complexity: 0.5)` — adds a topic with initial dwell score computed from weighted inputs
- `focus_on(topic_id:)` — boosts engagement score on a topic; increases dwell time
- `disengage(topic_id:, force: 0.0)` — reduces engagement; `force` parameter accelerates disengagement
- `decay(engine: nil)` — applies dwell decay to all topics; returns decayed count
- `current_topic` — the topic with the highest current dwell score
- `sticky_topics` — topics above `STICKY_THRESHOLD` (dwell >= 0.7)
- `ruminating_topics` — topics above `RUMINATION_THRESHOLD` (dwell >= 0.9)
- `most_engaging(limit: 5)` — top topics by engagement score
- `dwell_report` — full report: totals, sticky count, rumination count, average dwell
- `status` — engine summary

## Helpers

- `DwellEngine` — manages topics. Dwell score = `BASE_DWELL + (salience * SALIENCE_WEIGHT) + (novelty * NOVELTY_WEIGHT) + (emotional_intensity * EMOTION_WEIGHT) + (complexity * COMPLEXITY_WEIGHT)`. `decay_all!` applies `DWELL_DECAY` to all topics.
- `DwellTopic` — has `content`, `topic_type`, `dwell_score`, `engagement`, `salience`, `novelty`, `emotional_intensity`, `complexity`. `focus!` boosts engagement. `disengage!(force)` reduces both dwell and engagement.

## Integration Points

- `lex-cognitive-echo` models residual activation from past processing — dwell is the active attention complement: echo is background, dwell is foreground.
- `lex-tick` can check `ruminating_topics` in the health phase to detect unhealthy attention loops and trigger defusion or disengagement.
- Emotional weight (`EMOTION_WEIGHT = 0.3`) is the highest single factor — emotionally intense topics naturally attract longer dwell, modeling the affect-attention link.

## Development Notes

- `current_topic` returns the single highest-dwell topic — the agent's most attended-to concept at any moment.
- `RUMINATION_THRESHOLD = 0.9` is deliberately high — rumination is a clinical-level concern, not normal engagement.
- `disengage(force: 0.0)` with default force is gentle; `force: 1.0` enables hard disengagement override.
- Dwell decay applies to all topics including the current topic — active engagement requires periodic `focus_on` calls to maintain dwell level.
