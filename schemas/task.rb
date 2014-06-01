schema "001" do
  entity "Task" do
    string :title, optional: false
    datetime :started_at, optional: false
    decimal :status, optional: false, default: 1
  end
end

schema "002" do
  entity "Task" do
    string :title, optional: false
    datetime :started_at, optional: false
    datetime :finished_at, optional: true
    decimal :status, optional: false, default: 1
  end
end
