public enum TileType {
    EMPTY(false, false, false),
    SOLID(true, false, false),
    DAMAGING(false, true, false),
    PUSHABLE(false, false, true);

    public final boolean solid;
    public final boolean damaging;
    public final boolean pushable;

    TileType(boolean solid, boolean damaging, boolean pushable) {
        this.solid = solid;
        this.damaging = damaging;
        this.pushable = pushable;
    }
}
