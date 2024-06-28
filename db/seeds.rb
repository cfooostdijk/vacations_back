employees = Employee.create([
  { first_name: 'Juan', last_name: 'Pérez', email: 'juan.perez@example.com', lider: "Alan" },
  { first_name: 'Ana', last_name: 'García', email: 'ana.garcia@example.com', lider: "Alan" },
  { first_name: 'Carlos', last_name: 'López', email: 'carlos.lopez@example.com', lider: "Carolina" }
])

Vacation.create([
  { employee_id: employees[0].id, vacation_start: '2024-07-01', vacation_end: '2024-07-15', kind: 'annual', motive: 'vacation', status: 'approved' },
  { employee_id: employees[1].id, vacation_start: '2024-08-01', vacation_end: '2024-08-10', kind: 'sick', motive: 'medical', status: 'pending' },
  { employee_id: employees[2].id, vacation_start: '2024-09-01', vacation_end: '2024-09-15', kind: 'annual', motive: 'family trip', status: 'approved' },
  { employee_id: employees[0].id, vacation_start: '2024-12-01', vacation_end: '2024-12-10', kind: 'sick', motive: 'medical', status: 'denied' }
])
