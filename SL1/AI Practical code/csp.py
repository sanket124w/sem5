class CSP:
    def __init__(self, variables, domains, neighbors):
        self.variables = variables
        self.domains = domains
        self.neighbors = neighbors
        self.assignments = {}

    def solve(self):
        return self._backtrack()

    def _backtrack(self):
        if len(self.assignments) == len(self.variables):
            return self.assignments

        unassigned_var = self._select_unassigned_variable()
        for value in self.domains[unassigned_var]:
            if self._is_consistent(unassigned_var, value):
                self.assignments[unassigned_var] = value

                # For simplicity, this example primarily relies on the consistency check during backtracking.
                result = self._backtrack()
                if result is not None:
                    return result

                del self.assignments[unassigned_var]  # Backtrack

        return None

    def _select_unassigned_variable(self):
        unassigned = [var for var in self.variables if var not in self.assignments]
        if not unassigned:
            return None
        return min(unassigned, key=lambda var: len(self.domains[var]))

    def _is_consistent(self, var, value):
        for neighbor in self.neighbors.get(var, []):
            if neighbor in self.assignments and self.assignments[neighbor] == value:
                return False
        return True

# Example Usage: Map Coloring
if __name__ == "__main__":
    regions = ["WA", "NT", "SA", "Q", "NSW", "V", "T"]
    colors = ["red", "green", "blue"]
    domains = {region: colors for region in regions}
    neighbors = {
        "WA": ["NT", "SA"],
        "NT": ["WA", "SA", "Q"],
        "SA": ["WA", "NT", "Q", "NSW", "V"],
        "Q": ["NT", "SA", "NSW"],
        "NSW": ["Q", "SA", "V"],
        "V": ["SA", "NSW", "T"],
        "T": ["V"]
    }

    csp_solver = CSP(regions, domains, neighbors)
    solution = csp_solver.solve()

    if solution:
        print("Map Coloring Solution:")
        for region, color in solution.items():
            print(f"{region}: {color}")
    else:
        print("No solution found for the map coloring problem.")
