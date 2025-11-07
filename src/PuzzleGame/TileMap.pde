import javax.swing.*;
import java.awt.*;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class TileMap extends JPanel {
    private static final int WIDTH = 10;
    private static final int HEIGHT = 10;
    private Tile[][] tiles = new Tile[WIDTH][HEIGHT];

    public TileMap() {
        setPreferredSize(new Dimension(WIDTH * Tile.SIZE, HEIGHT * Tile.SIZE));

        // Fill grid with demo tiles
        for (int x = 0; x < WIDTH; x++) {
            for (int y = 0; y < HEIGHT; y++) {
                TileType type;
                Color color;

                if (y == 0 || y == HEIGHT - 1 || x == 0 || x == WIDTH - 1) {
                    type = TileType.SOLID;
                    color = Color.GRAY;
                } else if ((x + y) % 5 == 0) {
                    type = TileType.DAMAGING;
                    color = Color.RED;
                } else {
                    type = TileType.EMPTY;
                    color = Color.WHITE;
                }

                tiles[x][y] = new Tile(type, color);
            }
        }

        addMouseListener(new MouseAdapter() {
            @Override
            public void mousePressed(MouseEvent e) {
                int x = e.getX() / Tile.SIZE;
                int y = e.getY() / Tile.SIZE;

                if (x >= 0 && x < WIDTH && y >= 0 && y < HEIGHT) {
                    Tile current = tiles[x][y];
                    TileType nextType = getNextType(current.getType());
                    tiles[x][y] = new Tile(nextType, getColorForType(nextType));
                    repaint();
                }
            }
        });
    }

    private TileType getNextType(TileType type) {
        return switch (type) {
            case EMPTY -> TileType.SOLID;
            case SOLID -> TileType.DAMAGING;
            case DAMAGING -> TileType.PUSHABLE;
            case PUSHABLE -> TileType.EMPTY;
        };
    }

    private Color getColorForType(TileType type) {
        return switch (type) {
            case EMPTY -> Color.WHITE;
            case SOLID -> Color.GRAY;
            case DAMAGING -> Color.RED;
            case PUSHABLE -> Color.GREEN;
        };
    }

    @Override
    protected void paintComponent(Graphics g) {
        super.paintComponent(g);

        for (int x = 0; x < WIDTH; x++) {
            for (int y = 0; y < HEIGHT; y++) {
                tiles[x][y].draw(g, x * Tile.SIZE, y * Tile.SIZE);
            }
        }
    }
}
