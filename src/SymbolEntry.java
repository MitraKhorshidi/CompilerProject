class SymbolEntry {
    int id;
    ValueType type;
    String name;
    Object value;

    public SymbolEntry(int id, ValueType type, String name, Object value) {
        this.id = id;
        this.type = type;
        this.name = name;
        this.value = value;
    }

    @Override
    public String toString() {
        return "Symbol{" +
                "id=" + id +
                ", type=" + type +
                ", name='" + name + '\'' +
                ", value=" + value +
                '}';
    }
}
