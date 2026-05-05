---
layout: default
---

{% assign featured_review = site.reviews | where: "featured", true | first %}
{% assign other_reviews = site.reviews | where_exp: "item", "item.featured != true" %}
{% assign secondary_reviews = other_reviews | slice: 3, 4 %}
{% assign top_games = site.reviews | sort: "score" | reverse | slice: 0, 9 %}

<!-- HERO SECTION -->
<section class="hero-section">
  <div class="section-rule">
    <span>Editor's Pick &mdash; This Week</span>
  </div>
  <article class="hero-card">
    <div class="hero-art">
    </div>
    <div class="hero-body">
      <div>
        <div class="review-meta">
          <span class="badge badge-featured">Editor's Pick</span>
          <span class="badge badge-strategy">{{ featured_review.category | default: "Strategy" }}</span>
        </div>
        <h2 class="review-title">{{ featured_review.game_name }}</h2>
        <p class="review-subtitle">{{ featured_review.publisher }} &mdash; {{ featured_review.players }}</p>
        <div class="stars">
          {% assign score_int = featured_review.score | floor %}
          {% for i in (1..5) %}
            {% if i <= score_int %}
              <span class="star">★</span>
            {% else %}
              <span class="star empty">★</span>
            {% endif %}
          {% endfor %}
        </div>
        <div class="review-excerpt">
          <p>{{ featured_review.excerpt | markdownify | strip_html | truncatewords: 70 }}</p>
        </div>
        <div class="game-stats">
          <div class="stat"><span class="stat-val">{{ featured_review.players_count }}</span><span>Players</span></div>
          <div class="stat"><span class="stat-val">{{ featured_review.playtime }}</span><span>Min</span></div>
          <div class="stat"><span class="stat-val">{{ featured_review.price | default: "$??" }}</span><span>MSRP</span></div>
          <div class="stat"><span class="stat-val">{{ featured_review.score }}</span><span>Score</span></div>
        </div>
      </div>
      <div>
        <div class="review-footer">
          <div class="reviewer-info">Reviewed by <strong>{{ featured_review.reviewer }}</strong><br>{{ featured_review.date | date: "%B %d, %Y" }}</div>
          <a href="{{ featured_review.url }}" class="read-more">Read Full Review</a>
        </div>
      </div>
    </div>
  </article>
</section>

{% include reviews.html %}

<!-- MAIN + SIDEBAR -->
<div class="main-layout homepage-more-reviews">
  <section>
    <div class="section-rule">
      <span>More Reviews</span>
    </div>
    <div class="secondary-reviews">
      {% for review in secondary_reviews %}
      <article class="list-review">
        <div class="list-art">
          {% case review.game_slug %}
            {% when "catan-legacy" %}
              {% include list-svg-catan.html %}
            {% when "clockwork-empire" %}
              {% include list-svg-clockwork.html %}
            {% when "grove-quest" %}
              {% include list-svg-grove.html %}
            {% when "crimson-hand" %}
              {% include list-svg-crimson.html %}
            {% else %}
              <svg viewBox="0 0 100 80"><rect width="100" height="80" fill="#2e1a0a"/><text x="50" y="45" fill="white" font-size="10">{{ review.game_name }}</text></svg>
          {% endcase %}
        </div>
        <div class="list-body">
          <div>
            <div class="review-meta"><span class="badge badge-{{ review.category | downcase }}">{{ review.category }}</span></div>
            <h3 class="list-title">{{ review.game_name }}</h3>
            <p class="list-excerpt">{{ review.excerpt | strip_html | truncatewords: 18 }}</p>
          </div>
          <div class="list-meta">
            <span>By {{ review.reviewer }}</span>
            <span class="score-pill">{{ review.score }}</span>
            <span>{{ review.date | date: "%b %d, %Y" }}</span>
          </div>
        </div>
      </article>
      {% endfor %}
    </div>
  </section>

  <aside class="sidebar">
    <div class="sidebar-widget">
      <h3 class="widget-title">Top Games of 2026</h3>
      <ol class="top-list">
        {% for game in top_games %}
        <li>
          <span class="rank-num">{{ game.rank }}</span>
          <div>
            <div class="list-game-title">{{ game.title }}</div>
            <div class="list-game-meta">Score: {{ game.score }} &bull; {{ game.category }}</div>
          </div>
        </li>
        {% endfor %}
      </ol>
    </div>

  </aside>
</div>
