defmodule Novel.Repo.Migrations.CreateAssignmentResults do
  use Ecto.Migration

  def up do
    execute """
      CREATE VIEW assignment_results AS
        SELECT
          e.id AS enrollment_id,
          l.id AS lab_id,
          bool_or(s.is_approved) AS is_passed
        FROM university_enrollments e
          INNER JOIN assignment_labs l
            ON l.course_id = e.course_id
          LEFT OUTER JOIN assignment_submissions s
            ON l.id = s.lab_id AND s.enrollment_id = e.id
        GROUP BY e.id, l.id
        ORDER BY e.id ASC, l.id ASC
        ;
    """
  end

  def down do
    execute "DROP VIEW assignment_results;"
  end
end
