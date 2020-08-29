/*
 * Copyright (c) 2019-2020, somewhere (somewhere0813@gmail.com).
 * <p>
 * Licensed under the GNU Lesser General Public License 3.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * <p>
 * https://www.gnu.org/licenses/lgpl.html
 * <p>
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.albedo.java.modules.tool.service;

import com.albedo.java.common.persistence.service.BaseService;
import com.albedo.java.modules.tool.domain.AlipayConfig;
import com.albedo.java.modules.tool.domain.vo.TradePlus;
import com.albedo.java.modules.tool.domain.vo.TradeVo;
import com.alipay.api.AlipayApiException;

/**
 * @author somewhere
 * @since 2019/2/1
 */
public interface AliPayService extends BaseService<AlipayConfig> {

  /**
   * 查询配置
   *
   * @return AlipayConfig
   */
  AlipayConfig find();

  /**
   * 更新配置
   *
   * @param alipayConfig
   *          支付宝配置
   * @return AlipayConfig
   */
  AlipayConfig config(AlipayConfig alipayConfig);

  /**
   * 处理来自PC的交易请求
   *
   * @param alipay
   *          支付宝配置
   * @param trade
   *          交易详情
   * @return String
   * @throws Exception
   *           异常
   */
  String toPayAsPc(AlipayConfig alipay, TradeVo trade) throws Exception;

  /**
   * 处理来自手机网页的交易请求
   *
   * @param alipay
   *          支付宝配置
   * @param trade
   *          交易详情
   * @return String
   * @throws Exception
   *           异常
   */
  String toPayAsWeb(AlipayConfig alipay, TradeVo trade) throws Exception;

  /**
   * 处理来自PC的交易请求
   *
   * @param trade
   *          交易详情
   * @return String
   * @throws Exception
   *           异常
   */
  String toPayAsPc(TradeVo trade) throws Exception;

  String toPayAsPc(TradePlus trade) throws Exception;

  /**
   * 查询订单支付状态
   *
   * @param outTradeNo
   *          支付宝订单号
   * @return
   *         支付状态
   */
  String queryOrderStatus(String outTradeNo) throws AlipayApiException;
}
