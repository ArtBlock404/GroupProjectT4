import java.awt.*;

public class Tile {
    public static final int SIZE = 20;
    private TileType type;
    private Color color;

    public Tile(TileType type, Color color) {
        this.type = type;
        this.color = color;
    }

    public TileType getType() {
        return type;
    }

    public void draw(Graphics g, int x, int y) {
        g.setColor(color);
        g.fillRect(x, y, SIZE, SIZE);
        g.setColor(Color.DARK_GRAY);
        g.drawRect(x, y, SIZE, SIZE);
    }
}
