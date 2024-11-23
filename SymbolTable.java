import java.util.Hashtable;

public class SymbolTable {
    
    public class Sym {
		public Sym (String id, int t) {
			myName = id;
			myType = t; 
		}
		public String name () { return myName; }
		public int type () { return myType; }

		// private fields
		private String myName;
		private int myType;
    };

    Hashtable table;

    SymbolTable () { table = new Hashtable(); }

    public Sym lookup (String name) { 
		return (Sym) table.get(name); 
    }

    public Sym insert (String name, int type) {
		if (table.containsKey(name)) 
			return (Sym) table.get(name);
		Sym sym = new Sym(name, type);
		table.put(name, sym);
		return sym;
    }
}
