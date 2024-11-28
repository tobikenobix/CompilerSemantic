import java.util.ArrayList;
import java.util.Hashtable;

public class SymbolTable {
    
    public class Sym {
		public Sym (String id, int t) {
			myName = id;
			myType = t; 
		}

		//attach list for method
		public Sym(String id, int t, FormalsListNode list) {
			myName = id;
			myType = t;
			myList = list;
		}

		public String name () { return myName; }
		public int type () { return myType; }
		public FormalsListNode list() { return myList; }

		// private fields
		private String myName;
		private int myType;
		private FormalsListNode myList;
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

	public Sym insert (String name, int type, FormalsListNode list) {
		if (table.containsKey(name))
			return (Sym) table.get(name);
		Sym sym = new Sym(name, type, list);
		table.put(name, sym);
		return sym;
	}

	@Override
	public String toString() {
		return table.toString();
	}
}
