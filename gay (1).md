# Sea1 — 39 Island Secrets / BonusMoments trong dump

**Đã đối chiếu đủ 39/39 tên người dùng liệt kê.** Đây là hệ thống nhiệm vụ khám phá/hoạt động trên đảo, **khác nhánh event theo mùa `MagnetEvent26`**. Lượt kiểm tra trước tập trung event theo mùa nên chưa bao quát nhóm này.

| Kết quả từ definition | Số lượng |
|---|---:|
| BonusMoments khớp danh sách | **39** |
| Đảo có các quest này | **13**, mỗi đảo 3 quest |
| Có tag `Repeatable` | **20** |
| Có tag `AwakenedBossBattle` | **10**, đều nằm trong nhóm Repeatable |
| Có tag `ResetOnDeath` | **1** — The Clown's Jewels |

Nguồn chính: `scripts_part_2.txt`, các definition **45692–46545**. Toàn văn bốn file đã được quét theo tên quest và tham chiếu liên quan; các module khớp được đọc để phân biệt dữ liệu mô tả, logic client và dữ liệu do server quyết định. Không thực thi script hoặc kết nối server game.

## 1. Quan trọng: `Completed: false` chưa đủ để nói “chưa làm cả 39”

Cần biết đoạn code tạo danh sách đã lấy trường này **từ đâu**:

1. **Nếu lấy từ definition trong `Definitions.Map`:** mỗi BonusMoment chỉ có `Index`, `Dialogue`, `Tags`; **không có `Completed`**. Viết `definition.Completed or false` sẽ in `false` kể cả khi nhân vật đã hoàn thành. Xem **P2:44802–44836** và **P2:46590–46605**.
2. **Nếu lấy từ `BonusMomentsController:GetLoadedMoments()`:** cờ runtime `Completed` được giữ `false` với quest lặp lại, dù `Completions > 0`. Controller cũng có cờ `Active` riêng. Xem **P2:2024–2040**, **P2:2083–2105**.
3. **Tiến độ dùng cho map/UI:** hook `useBonusMoments` lấy `GetMomentProgress`, nhận `Data[address]` dạng boolean rồi đưa ra `IsCompleted`. Đây mới là luồng đối chiếu phù hợp cho trạng thái đã hoàn thành trên map. Xem **P3:22985–22993**, **P3:23025–23037**.

Nếu danh sách của bạn đã đọc đúng kết quả `GetMomentProgress` và các giá trị thực sự là `false`, thì đó là trạng thái server đang trả về. **Chưa có code tạo danh sách nên chưa thể kết luận danh sách sai, hay nhân vật thật sự đang 0/39.** Trường bị thiếu/lỗi tải cũng không nên tự đổi thành `false`.

Logic runtime rút gọn từ **P2:2083–2092**, chỉ để giải thích — không phải đoạn đặt trạng thái hoàn thành:

```lua
-- Khi quest lặp lại, Completed có thể false dù đã làm một hay nhiều lần.
local function runtimeCompleted(completions, repeatable)
    return completions > 0 and not repeatable
end

assert(runtimeCompleted(1, true) == false)
-- Cần phân biệt cờ runtime này với progress đã lưu mà map/UI sử dụng.
```

## 2. Danh sách đầy đủ và gợi ý tìm được

**R** = `Repeatable` · **B** = `AwakenedBossBattle` · **D** = `ResetOnDeath` · **—** = không có các tag trên trong definition, không phải kết luận về mọi điều kiện server.

**Phần dưới là gợi ý có căn cứ từ code/lời thoại, không phải walkthrough đã được kiểm thử trong game.** Nhiều definition chỉ chứa lời đồn và lời thoại sau khi hoàn thành, không có toàn bộ thuật toán quest.

Quy ước nguồn: **P1/P2/P3/P4** tương ứng `scripts_part_1/2/3/4.txt`; số phía sau là dòng trong file gốc. Đường dẫn mọi quest là `Sea1/<đảo>/<tên quest>`.

### Colosseum

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 1 | **Crowd Favorite** | R | Gợi ý nói về phá các bia/target để biểu diễn cho khán giả Colosseum. Chưa thấy đủ luật tính điểm hoặc số target cần phá. | P2:45692–45702 |
| 2 | **King's Apprentice** | — | Nói chuyện với Emperor, nhận thử thách rồi bước vào đấu trường để đấu Gladiators. Số vòng và điều kiện thắng cụ thể chưa được xác nhận. | P2:45703–45713; P1:23968–23988 |
| 3 | **Legendary Creator Statues** | — | Đánh từng Former Champion bằng đúng loại vũ khí. Client có các nhóm Melee, Sword, Gun, Fruit; chưa có đủ dữ liệu để chỉ định vũ khí cho từng tượng. | P2:45714–45724; P1:23998–24002; P1:471304–471318 |

### Desert

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 4 | **Archaeologist's Tablet** | — | Gợi ý dẫn tới các trụ/phiến đá cổ bị cát vùi trong tàn tích. Lời thoại thưởng xác nhận việc đánh thức các trụ; chưa thấy thứ tự giải cụ thể. | P2:45755–45770 |
| 5 | **Prickly Harvest** | R | Gặp Desert Merchant khi xương rồng đang nở; thu đủ 10 Cactus Petals rồi mang về. Có trạng thái Unavailable khi hoa chưa sẵn sàng. | P2:45771–45781; P1:24236–24280 |
| 6 | **Rescue Hasan** | — | Tìm Hasan ở khu dưới kim tự tháp, xử lý skeletons, nói chuyện nhận lời cảm ơn rồi quay lại Desert Merchant theo lời dặn. | P2:45782–45792; P1:24204–24208; P1:26119–26135 |

### Fountain

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 7 | **Fountain Pipe Repair** | — | Tên quest và lời thoại hướng tới sửa hệ thống ống, đẩy chiếc thuyền bị kẹt khỏi vòi phun. Chưa có đủ bước của minigame sửa chữa. | P2:45823–45833 |
| 8 | **Fountain Wire Repair** | R · B | Chờ/tìm hiện tượng dây điện tóe lửa và nhánh sửa điện; lời thoại hoàn thành nhắc đánh bại Cyborg được nạp đầy năng lượng. | P2:45834–45844 |
| 9 | **Sewer Gangs** | R | Dọn băng nhóm ngầm của Megalo trong cống Fountain City. Config riêng còn có cần cẩu/lối vào SewerEntrance và các tường BreakableWall. | P2:45845–45855; P2:108117–108150 |

### Frozen Village

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 10 | **Breaking the Ice** | — | Giải cứu Ability Teacher bị mắc trong băng. Lời thoại có nhắc thưởng sức mạnh, nhưng không có con số hay bảng phát thưởng. | P2:45886–45896 |
| 11 | **Frozen Defense** | R · B | Liên quan năng lượng nguyền rủa trong băng và đánh bại Yeti bị nguyền. Không có giờ kích hoạt cố định trong definition. | P2:45897–45907 |
| 12 | **Snowman** | R | Khi tuyết rơi, lăn/ghép ba quả cầu tuyết thành Snowman; số ba được nhắc rõ trong lời thoại hoàn thành. | P2:45908–45918 |

### Jungle

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 13 | **Banana Tree** | R · B | Khi đúng thời điểm, quả đặc biệt xuất hiện trên cây; nhánh này kết thúc bằng trận Gorilla King thức tỉnh. Chưa chốt cách kích hoạt bằng quả. | P2:45949–45959 |
| 14 | **The Thieving Monkey** | R | Tìm con khỉ trốn trên cây đã trộm mũ, lấy mũ trả lại người mất. Chưa có vị trí cây cố định từ definition. | P2:45960–45970 |
| 15 | **Zipline Repair** | — | Khôi phục zipline giữa các đảo Jungle bằng Grappling Hook. Mô tả vật phẩm xác nhận hook/rope dùng để nối lại zipline. | P2:45971–45981; P1:74625–74626; P1:468248 |

### Magma Village

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 16 | **Evil Slimes** | — | Kiểm tra các mạch phun/geyser bất thường rồi xử lý slime. Chưa có số lượng slime hoặc thứ tự kích hoạt. | P2:46012–46022 |
| 17 | **Magma Ore Extraction** | R | Lời thoại nhấn mạnh dọn nhóm prospectors trên đảo; không đủ căn cứ biến tên quest thành yêu cầu đào một số quặng cố định. | P2:46023–46033 |
| 18 | **One Last Eruption** | R · B | Theo dấu núi lửa rung/chuyển động và đánh bại Magma General trong nhánh boss thức tỉnh. | P2:46034–46044 |

### Marine Fortress

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 19 | **Battle Plans** | R | Đánh lui nhóm cướp biển tấn công Marine Fortress. Definition không cho số đợt địch. | P2:46075–46085 |
| 20 | **Fortress Flagpole** | — | Đổi lá cờ trên pháo đài; lời thoại thưởng nhắc chân dung người giao việc xuất hiện trên cờ. Thiếu các bước tương tác chi tiết. | P2:46086–46096 |
| 21 | **Fortress Under Fire** | R · B | Dùng đại bác của pháo đài bắn vào keep để kéo Vice Admiral khỏi vị trí và bước vào trận boss thức tỉnh. | P2:46097–46107 |

### Middle Town

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 22 | **Early Access** | — | Tìm đường vào mansion đang khóa, nơi nhóm làm game chỉ cho tester vào. Chưa tìm thấy điều kiện cấp quyền tester trong definition. | P2:46168–46178 |
| 23 | **Lookout** | — | Gặp Experienced Captain, quan sát và đếm tàu theo tiêu chí được hỏi, vượt bốn vòng. Số tàu mỗi vòng trong config là 3/5/8/11, KHÔNG phải bốn đáp án cố định. | P2:46179–46189; P1:26468–26507; P1:27005; P1:27276 |
| 24 | **X Marks The Spot** | — | Tìm kho báu chôn giấu tại Middle Town. Chưa có tọa độ chỗ đào hoặc thứ tự manh mối. | P2:46190–46200 |

### Pirate Village

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 25 | **Chef's Kiss** | R · B | Liên quan công thức nấu ăn và đánh bại Chef thức tỉnh. Chưa chốt danh sách nguyên liệu hoặc thời điểm kích hoạt. | P2:46261–46271 |
| 26 | **Tavern Brawl** | R | Xử lý đám gây rối trong tavern để giúp bartender. Definition không nêu số mob. | P2:46272–46282 |
| 27 | **Windmill Maintenance** | — | Sửa/khôi phục cối xay gió đang gần như ngừng quay. Chưa có đủ chi tiết minigame. | P2:46283–46293 |

### Prison

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 28 | **Don Megalo** | — | Lấy áo của Don Megalo. Cell Block Key được mô tả là chìa khóa từ sân tù mở cổng văn phòng của Don; chưa chốt vị trí lấy chìa cụ thể. | P2:46324–46334; P1:74689–74690 |
| 29 | **Escape from Alcatraz** | — | Bắt lại ba tù nhân trốn trại và giúp Vice Warden khôi phục trật tự. Số ba có trong lời thoại thưởng. | P2:46335–46345 |
| 30 | **Lever Jailbreak** | R · B | Nhánh mở phòng giam/jailbreak dẫn tới trận Warden thức tỉnh; lời thoại hoàn thành nhắc toàn bộ nhà tù náo loạn. | P2:46346–46356 |

### Sky

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 31 | **Electric Fighting Teacher** | — | Mang một vật phẩm được mô tả là “piece of the sky”/“raw current” cho võ sư. Chưa đủ bằng chứng để gán một tên item hoặc số lượng cụ thể. | P2:46387–46397 |
| 32 | **The Clown's Jewels** | R · D | Liên quan kho báu của bandits ở Skylands. Có tag ResetOnDeath; definition chưa giải thích đầy đủ trạng thái nào bị reset khi chết. | P2:46398–46408 |
| 33 | **Unexpected Guest** | R | Xử lý cướp biển lẻn vào lâu đài; lời thoại có kho tiền và battle plans. Không đủ dữ liệu để xác định toàn bộ tuyến đường trong lâu đài. | P2:46409–46419 |

### SkyArea2

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 34 | **Echoes Through the Clouds** | R · B | Khi đúng thời điểm, tương tác Golden Bell để đi vào nhánh boss sấm sét. Definition không ghi tên boss cụ thể, nên không gán tên từ suy đoán. | P2:46450–46460 |
| 35 | **Temple Intel** | — | Tìm lại bí mật/kho báu tia sét bị giấu trong đền. Có các FX/puzzle tham chiếu Temple Intel, nhưng chưa chốt được nghiệm của puzzle. | P2:46461–46471; P4:198794–198812 |
| 36 | **The Tyrant Awakens** | R · B | Theo hiện tượng mây giông đen trên đền; lời thoại hoàn thành nhắc hạ “Tyrant’s apprentice”. Chưa gán tên boss khác ngoài lời thoại. | P2:46472–46482 |

### Underwater City

| # | Quest | Tag | Gợi ý / phần đã xác nhận | Nguồn |
|---:|---|---|---|---|
| 37 | **Beyond the Bubble** | — | Dùng các bong bóng nổi để lên khu hang phía trên thành phố và dọn mối đe dọa trong hang. | P2:46513–46523 |
| 38 | **Fishman Karate** | — | Giải tương tác ánh sáng ở các tảng đá sau cung điện để mở cửa kín, gặp Water Kung Fu Teacher. Không đồng nghĩa nhận fighting style miễn phí ngay. | P2:46524–46534 |
| 39 | **Pearl of the Deep** | R · B | Khi trai chuyển đen, lấy black pearl để gọi/đối mặt Fishman Lord thức tỉnh. Không có giờ spawn cụ thể trong definition. | P2:46535–46545 |

## 3. Những nội dung khác gắn với hệ thống này

### A. Secrets Master và nhánh Advanced Combat

Có thêm nội dung ngoài 39 tên trong danh sách:

- Hoàn thành **ít nhất một đảo**: UI Secrets Master có mục **“Which boss stirs next?”**, hỏi server về boss/đảo sắp hoạt động. Lời thoại xử lý cả trạng thái chờ, sắp thức tỉnh, đã kích hoạt và bị trận khác chặn. **P1:28574–28606**, **P1:28752–28770**.
- Hoàn thành **ít nhất ba đảo**, trong khi Middle Town chưa hoàn tất: có lựa chọn hỏi gợi ý hữu ích về Middle Town. Đây là điều kiện của lựa chọn hội thoại, **không phải bằng chứng mọi quest Middle Town bắt buộc đủ ba đảo mới làm được**. **P1:28740–28751**.
- Khi hoàn thành tất cả các đảo có BonusMoments trong map hiện tại, UI mới lấy phase từ server. Có phase **Stories** và **Complete**; ở `Complete` có lựa chọn **Advanced Combat / Combat**. **P1:28618–28646**, **P1:28679–28680**, **P1:28771–28847**.
- Lời thoại cuối nhắc khôi phục thác nước và “One fist, no shortcuts”. **Chưa có đủ logic server để biến câu này thành hướng dẫn mở khóa hoàn chỉnh. Không khẳng định làm xong 39 quest là lập tức nhận Advanced Combat.**

### B. Secret Levels: có liên quan tăng trần cấp độ

Trong `Util.LevelCap`:

- Base level cap: **2800**.
- Extension `SECRETS`: tối đa **200**; theoretical max là **3000**.
- Helper cộng **4** cho mỗi record `BonusMoments` được đánh dấu `Completed`, và **4** cho mỗi entry trong `CompletedMaps`, rồi giới hạn phần cộng thêm ở 200.

Nguồn: **P1:392866–392896**, **P1:392928–392944**.

**Đây là mở rộng trần level, không tự tặng bốn level nhân vật cho mỗi quest.** Chỉ riêng 39 record hoàn thành tương ứng 156 trong phép tính; dump client chưa cho đủ cách server ghi `CompletedMaps`, nên không suy ra “39 quest tự động = +200”. Không nhầm record tiến độ lưu với cờ runtime `Completed` của controller ở mục 1.

### C. Ba quest mỗi đảo và teleporter

`getIfIslandComplete` kiểm tra toàn bộ BonusMoments của đảo. Hook `useTeleportable` còn kiểm tra level và các tag chặn; đảo Starter được xử lý riêng. **Middle Town có `GatewayBlocked` trong bản dump này**, nên không nên hứa mọi đảo cứ 3/3 là sẽ có teleporter dùng được.

Nguồn: **P2:44417–44426**, **P2:46148**, **P3:23193–23208**.

### D. Một số vật phẩm/nhánh thưởng xác nhận được

- `Cactus Petal [Tool-1581]`, `Refreshing Drink [Tool-1582]`: dữ liệu mô tả liên quan Desert Merchant; nhánh trả thưởng có câu “Here's a free drink.” **P1:24279–24280**, **P1:74593–74610**.
- `Grappling Hook [Tool-1583]`: mô tả dùng để nối lại zipline. **P1:74625–74626**.
- `Cell Block Key [Tool-1587]`: mô tả mở cổng văn phòng Don Megalo. **P1:74689–74690**.
- Sau nhánh giải cứu Hasan, UI có thể mở hội thoại mua **Swordsman Hat**, giá hiển thị **$150,000**, còn kiểm tra điều kiện phía server. **Đây là lựa chọn mua, không phải bằng chứng quest tặng mũ miễn phí.** **P1:26135–26168**.

`setRewardDialogue(...)` chỉ cấu hình **lời thoại**. Nó không tự chứng minh số Beli, EXP, fragments hay mức tăng sức mạnh thật sự được phát; muốn chốt cần dữ liệu phát thưởng phía server hoặc kết quả trong game.

## 4. Điều chưa có để kết luận chắc

- Chưa có code tạo list `Completed: false` của người dùng, nên chưa xác định đó là definition, cờ runtime hay progress đã lưu.
- Chưa có đầy đủ logic server, điều kiện kích hoạt từng quest/boss, nghiệm mọi puzzle, tọa độ quest item, lịch spawn và bảng thưởng.
- “Khi đúng thời điểm”, “xương rồng nở” hoặc “có tuyết” trong lời thoại không đủ để tự gán chu kỳ giờ cố định hay lịch ngoài đời.
- Không có bản dump cũ để khẳng định từng module vừa được thêm trong lần cập nhật nào. Kết quả này xác nhận nội dung có trong bốn file đã gửi.

**Chốt lại:** không chỉ có Magnet Event. Còn cả hệ thống **39 BonusMoments trên 13 đảo Sea1**, gồm **20 mục lặp lại, 10 nhánh boss thức tỉnh**, cùng tiến độ map, Secret Levels và nhánh Secrets Master/Advanced Combat.
