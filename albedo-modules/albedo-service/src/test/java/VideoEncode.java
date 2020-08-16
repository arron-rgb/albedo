import java.io.IOException;

import org.bytedeco.javacpp.Loader;
import org.junit.jupiter.api.Test;

/**
 * @author arronshentu
 */
public class VideoEncode {

  @Test
  public void test() {

    String ffmpeg = Loader.load(org.bytedeco.ffmpeg.ffmpeg.class);
    ProcessBuilder pb =
      new ProcessBuilder(ffmpeg, "-i", "/path/to/input.mp4", "-vcodec", "h264", "/path/to/output.mp4");
    try {
      pb.inheritIO().start().waitFor();
    } catch (InterruptedException | IOException e) {
      e.printStackTrace();
    }

  }

}
