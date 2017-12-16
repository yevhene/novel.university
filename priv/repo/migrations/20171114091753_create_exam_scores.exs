defmodule Novel.Repo.Migrations.CreateExamScores do
  use Ecto.Migration

  def up do
    execute """
      CREATE VIEW exam_scores AS
        WITH
        picks AS (
          SELECT
            at.id AS attempt_id,
            ps.is_picked AS is_picked,
            op.is_correct AS is_correct,
            op.is_correct AND ps.is_picked AS true_positive,
            NOT op.is_correct AND NOT ps.is_picked AS true_negative,
            NOT op.is_correct AND ps.is_picked AS false_positive,
            op.is_correct AND NOT ps.is_picked AS false_negative
          FROM exam_attempts at
          INNER JOIN exam_answers an
            ON at.id = an.attempt_id
          INNER JOIN exam_picks ps
            ON an.id = ps.answer_id
          INNER JOIN exam_options op
            ON op.id = ps.option_id
          ORDER BY at.id ASC
        ),
        attempts AS (
          SELECT
            attempt_id,
            COUNT(NULLIF(NOT true_positive, true)) AS true_positives,
            COUNT(NULLIF(NOT true_negative, true)) AS true_negatives,
            COUNT(NULLIF(NOT false_positive, true)) AS false_positives,
            COUNT(NULLIF(NOT false_negative, true)) AS false_negatives,
            COUNT(*) AS total
          FROM picks
          GROUP BY attempt_id
          ORDER BY attempt_id ASC
        ),
        values AS (
          SELECT
            attempt_id,
            (true_positives + true_negatives)::float / total AS value
          FROM attempts
        )
        SELECT
          attempt_id,
          value,
          value >= q.threshold AS is_passed
        FROM values v
        INNER JOIN exam_attempts a
          ON a.id = v.attempt_id
        INNER JOIN exam_quizzes q
          ON q.id = a.quiz_id
        ORDER BY attempt_id ASC
        ;
    """
  end

  def down do
    execute "DROP VIEW exam_scores;"
  end
end
