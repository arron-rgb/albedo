import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;

public class SendBatchSms {
  private static final String accessKeyId = "<accessKeyId>";
  private static final String secret = "<accessSecret>";
  private static final String templateCode = "template";
  private static final String domain = "dysmsapi.aliyuncs.com";

  public static void main(String[] args) {
    DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", accessKeyId, secret);
    IAcsClient client = new DefaultAcsClient(profile);

    CommonRequest request = new CommonRequest();
    request.setSysMethod(MethodType.POST);
    request.setSysDomain(domain);
    request.setSysVersion("2017-05-25");
    request.setSysAction("SendBatchSms");
    request.putQueryParameter("RegionId", "cn-hangzhou");
    // ["15900000000","13500000000"]
    String phoneNumber = "phoneNumber";
    request.putQueryParameter("PhoneNumberJson", phoneNumber);
    // 短信签名名称，JSON数组格式。
    // 请在控制台签名管理页面签名名称一列查看。
    // 说明 必须是已添加、并通过审核的短信签名；且短信签名的个数必须与手机号码的个数相同、内容一一对应。
    String signName = "signName";
    request.putQueryParameter("SignNameJson", signName);
    // 必须是已添加、并通过审核的模板CODE；
    request.putQueryParameter("TemplateCode", templateCode);
    try {
      CommonResponse response = client.getCommonResponse(request);
      System.out.println(response.getData());
    } catch (ServerException e) {
      e.printStackTrace();
    } catch (ClientException e) {
      e.printStackTrace();
    }
  }
}
