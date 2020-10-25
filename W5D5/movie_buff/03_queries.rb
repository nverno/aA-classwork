def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.
  
  # those_actors.inject(ActiveRecord.new) {|acc, act| acc.where(act) }
  # => where(a in x).where(b in x).where(...)...
  # actors IN [] => a in x || b in x || ...
  Movie
    .select(:id, :title)
    .joins(:actors)
    .where(actors: { name: those_actors }) #all those_actors  #Where{"name IN those_actors"}
    .group(:id)
    .having("COUNT(actors.id) = ?", those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  # require 'byebug'; debugger
  Movie
    .select('avg(score), (yr / 10) * 10 AS decade')
    .group('decade')
    .order('avg(score) DESC')
    .first
    .decade
end

def costars(name)
  # List the names of the actors that the named actor has ever
  # appeared with.
  # Hint: use a subquery
  sub =
    Movie
      .select(:id)
      .joins(:actors)
      .where(actors: {name: name}) #movies object with the actor in

  Actor
    .joins(:movies)
    .where('actors.name != ?', name) # .where.not(actors: {name: name}) ???
    .where(movies: {id: sub}) # one more where clause to filter out 'name'
    .order(:name)
    .distinct
    .pluck(:name)
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .left_outer_joins(:movies)
    .where(movies: { id: nil })
    .count
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the
  # letters in whazzername, ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but
  # not like "stallone sylvester" or "zylvester ztallone"
  re = "%#{whazzername.chars.join('%')}%"
  Movie
    .joins(:actors)
    .where("UPPER(actors.name) LIKE UPPER(?)", re)
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of
  # their career.
  Actor
    .select(:name, :id, "MAX(movies.yr) - MIN(movies.yr) AS career")
    .joins(:movies)
    .order('career DESC, name')
    .group('actors.id')
    .limit(3)
end
