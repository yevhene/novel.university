defmodule Novel.Repo.Migrations.CreateExamResults do
  use Ecto.Migration

  def up do
    execute """
      CREATE VIEW exam_results AS
        SELECT
          e.id AS enrollment_id,
          q.id AS quiz_id,
          MAX(s.value) AS score,
          bool_or(s.is_passed) AS is_passed
        FROM university_enrollments e
          INNER JOIN exam_quizzes q
            ON q.course_id = e.course_id
          LEFT OUTER JOIN exam_attempts a
            ON q.id = a.quiz_id AND a.enrollment_id = e.id
          LEFT OUTER JOIN exam_scores s
            ON a.id = s.attempt_id
        GROUP BY e.id, q.id
        ORDER BY e.id ASC, q.id ASC
        ;
    """
  end

  def down do
    execute "DROP VIEW exam_results;"
  end
end
