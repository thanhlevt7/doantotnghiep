<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

class Product extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $currentDate = Carbon::now('Asia/Ho_Chi_Minh');
        DB::table('products')->insert([
            [
                'id' => 1,
                'name' => 'Dâu tằm',
                'price' => 35000,
                'stock' => 20,
                'type' => 'Trái cây',
                'unit' => 'Kg',
                'description' => 'Quả dâu tằm có lợi trong việc cải thiện lưu lượng máu trong cơ thể, kiểm soát huyết áp và làm sạch máu. Các chất chống oxy hóa từ dâu sẽ hỗ trợ thúc đẩy chức năng của các mạch máu bằng cách giữ cho chúng dẻo dai và giãn nở.',
                'image' => 'https://product.hstatic.net/1000119621/product/417308_39dd0378fe9e43abbfc208eaa4e88e9f_large.jpg',
                'createDate' => "2022/10/07",
                'status' => 1,
            ],
            ['id' => 2,
                'name' => 'Rau salad',
                'price' => 30000,
                'stock' => 10,
                'type' => 'Rau củ',
                'unit' => '500gram',
                'description' => 'Rau xanh rất giàu canxi, vitamin K cao giúp hệ xương ổn định, phát triển khỏe mạnh. Củng cố xương, cải thiện mật độ xương, làm cho chúng dày và khỏe mạnh hơn',
                'createDate' => "2022/10/07",
                'image' => 'https://cf.shopee.vn/file/2003d66491a1c8fc3e629034b0288a74',
                'status' => 1,
            ],
            ['id' => 3,
                'name' => 'Nước suối',
                'price' => 7000,
                'stock' => 20,
                'type' => 'Thức uống',
                'unit' => 'Chai500ml',
                'description' => 'Nước còn mang lại rất nhiều lợi ích cho cơ thể khi được cung cấp đầy đủ chẳng hạn như: Giúp các khớp hoạt động tốt hơn, hoặc làm cho tim khỏe mạnh hơn',
                'createDate' => "2022/10/07",
                'image' => 'https://gaonuoc.com/wp-content/uploads/2019/09/thung-nuoc-khoang-lavie-750ml.jpg',
                'status' => 1,
            ],
            ['id' => 4,
                'name' => 'Kiwi',
                'price' => 200000,
                'stock' => 15,
                'type' => 'Trái cây',
                'unit' => 'Kg',
                'description' => 'Kiwi vào chế độ ăn uống của mình để đạt được những lợi ích chúng mang lại, có thể dễ dàng kết hợp nó vào một số công thức nấu ăn. Rất tuyệt để thêm kiwi vào bữa sáng. ',
                'createDate' => "2022/10/07",
                'image' => 'http://product.hstatic.net/1000346206/product/0-20141211-kiwi-1-1_grande.jpg',
                'status' => 1,
            ],
            ['id' => 5,
                'name' => 'Cam',
                'price' => 20000,
                'stock' => 20,
                'type' => 'Trái cây',
                'unit' => 'Kg',
                'description' => 'Quả cam rất giàu vitamin C, một dưỡng chất giúp hấp thụ sắt, làm tăng số lượng huyết sắc tố và ngăn ngừa các triệu chứng thiếu máu như mệt mỏi và chóng mặt',
                'createDate' => "2022/10/07",
                'image' => 'https://cooponline.vn/wp-content/uploads/2021/09/cam-vinh-kg.jpg,https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTC_6Be6fAMAE5ta5rIoPw3D7aqT5Fm8GrHjA&usqp=CAU',
                'status' => 1,
            ],
            ['id' => 6,
                'name' => 'Thịt bò',
                'price' => 200000,
                'stock' => 40,
                'type' => 'Thịt',
                'unit' => 'Kg',
                'description' => 'Thịt là nguồn cung cấp protein có vai trò chính trong xây dựng cơ bắp vì lý do đó, thịt là nguồn protein dồi dào có thể có lợi ích đặc biệt sau phẫu thuật hoặc cho các vận động viên phục hồi. ',
                'createDate' => "2022/10/07",
                'image' => 'https://thitbohuunghi.com/wp-content/uploads/2021/06/unnamed-1.jpg',
                'status' => 1,
            ],
            ['id' => 7,
                'name' => 'Nho đen',
                'price' => 100000,
                'stock' => 10,
                'type' => 'Trái cây',
                'unit' => 'Kg',
                'description' => 'Nho là loại quả chứa nhiều chất dinh dưỡng, chất xơ, kali... Nho cung cấp rất nhiều lợi ích sức khỏe do hàm lượng chất dinh dưỡng và chất chống oxy hóa cao. Dưới đây là 12 lợi ích sức khỏe hàng đầu của nho.',
                'createDate' => "2022/10/07",
                'image' => 'https://product.hstatic.net/1000372684/product/15._nho_den_4e21bd9031dc477190285cdc4bddd924_1024x1024.jpg',
                'status' => 1,
            ],
            ['id' => 8,
                'name' => 'Dâu tây',
                'price' => 210000,
                'stock' => 50,
                'type' => 'Trái cây',
                'unit' => 'Kg',
                'description' => 'Dâu tây sẽ rất có ích bởi chúng có khả năng chống viêm và làm sáng da. Thêm vào đó, vitamin C trong dâu tây hạn chế các bệnh về mắt như đục thủy tinh thể.',
                'createDate' => "2022/10/07",
                'image' => 'https://ifree.vn/wp-content/uploads/2018/12/chiet-xuat-dau-tay.jpg',
                'status' => 1,
            ],
            ['id' => 9,
                'name' => 'Táo mỹ',
                'price' => 109000,
                'stock' => 30,
                'type' => 'Trái cây',
                'unit' => 'Kg',
                'description' => 'Táo giúp hỗ trợ giảm cân do hàm lượng chất xơ trong táo thúc đẩy cảm giác no, giảm lượng calo và tăng giảm cân. - Ăn nhiều táo giúp tăng mật độ khoáng xương, giảm nguy cơ loãng xương;',
                'createDate' => "2022/10/07",
                'image' => 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSavrv-RJzhehL8cDGOQdFKTFFYtZzmhRNnE6nkKKKQgXbVgNvz1QX7mIq-slImoYOjQ1M&usqp=CAU',
                'status' => 1,
            ],
            [ 'id'=> 10,
            'name' => 'Cherry đỏ Chile',
            'price' =>  379000,
            'stock' => 30,
            'type' => 'Trái cây',
            'unit' => 'Kg',
            'description' => 'Quả cherry rất tốt cho những người bị cao huyết áp.  Nếu bạn ăn cherry thường xuyên, tình trạng mất ngủ của bạn sẽ được cải thiện. Cherry chứa melatonin làm cho giấc ngủ sâu và ngon hơn;',
            'createDate'=>$currentDate,
            'image' => 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTX9u4xVS-1KtooVh_F00ijZY8a2dtZqPkOtg&usqp=CAU',
            'status' => 1,
        ],
        ]);

    }}
