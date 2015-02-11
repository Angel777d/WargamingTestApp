/**
 * Created by angel777d on 09.02.2015.
 */
package {
public class Config {
    public static const DEFAULT_SIZE:int = 50;

    public static function get width():int {
        return DEFAULT_SIZE * 2;
    }

    public static function get height():int {
        return DEFAULT_SIZE;
    }

}
}
