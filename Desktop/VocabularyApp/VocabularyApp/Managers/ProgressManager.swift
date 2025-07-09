import Foundation
import Combine

// MARK: - ProgressManager
// Kullanıcının ilerlemesini (seviye, tamamlanan günler, kaydedilen kelimeler) yöneten sınıf.
class ProgressManager: ObservableObject {
    
    // MARK: - Published Properties
    @Published var userProgress: UserProgress {
        didSet {
            // userProgress değiştiğinde veriyi otomatik olarak kaydet.
            saveProgress()
        }
    }
    
    // MARK: - Private Properties
    private let userProgressKey = "userProgress" // UserDefaults için anahtar
    private let allLevels: [Level] // Tüm seviye verilerine erişim

    // MARK: - Initialization
    init(allLevels: [Level]) {
        
        self.allLevels = allLevels
        
       
        var initialProgress: UserProgress // Geçici bir değişken oluşturalım
        if let savedData = UserDefaults.standard.data(forKey: userProgressKey) {
            do {
                let decoder = JSONDecoder()
                initialProgress = try decoder.decode(UserProgress.self, from: savedData)
                print("Kullanıcı ilerlemesi yüklendi. Mevcut seviye:\(initialProgress.currentLevel), Tamamlanan gün: \(initialProgress.completedDays)")
            } catch {
                print("Hata: Kullanıcı ilerlemesi yüklenemedi: \(error.localizedDescription)")
                initialProgress = UserProgress() // Hata durumunda varsayılan
            }
        } else {
            print("Kayıtlı ilerleme bulunamadı. Varsayılan ile başlanıyor")
            initialProgress = UserProgress() // Kayıtlı veri yoksa varsayılan
        }
        // _userProgress özelliğini Published ile başlat
        _userProgress = Published(initialValue: initialProgress)
        
        
    }
    
    // MARK: - Public Methods
    func completeDay() {
        userProgress.completedDays += 1
        print("Tebrikler 🎉 Gün Tamamlandı! Toplam tamamlanan gün: \(userProgress.completedDays)")
        
        let daysPerLevel = 1 // Bir seviye atlamak için tamamlanması gereken gün sayısı
        if userProgress.completedDays % daysPerLevel == 0 {
            
            let nextLevelNumber = userProgress.currentLevel + 1
            
          
            if allLevels.contains(where: { $0.levelNumber == nextLevelNumber }) {
                userProgress.currentLevel = nextLevelNumber // Bu satır eksikti!
                print("Seviye atlandı! Yeni seviye: \(userProgress.currentLevel)")
            } else {
                print("Tebrikler! Tüm seviyeler tamamlandı.")
            }
        }
    }
    
    func addWordToSavedWords(_ word: Word) {
        if !userProgress.saveWords.contains(where: { $0.id == word.id }) {
            userProgress.saveWords.append(word)
            print("Kelime '\(word.english)' kaydedildi.")
        } else {
            print("Kelime '\(word.english)' zaten kaydedilmiş.")
        }
    }
    
    func removeWordFromSavedWords(_ word: Word) {
        userProgress.saveWords.removeAll { $0.id == word.id }
        print("Kelime kaydedilen kelimelerden silindi.")
    }
    
    // MARK: - Data Persistence Methods
    
    /// İlerlemeyi UserDefaults'a kaydederiz.
    private func saveProgress() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(userProgress)
            UserDefaults.standard.set(data, forKey: userProgressKey)
            print("Kullanıcı ilerlemesi kaydedildi.")
        } catch {
            print("Hata: Kullanıcı ilerlemesi kaydedilemedi: \(error.localizedDescription)")
        }
    }
    
  
    func resetProgress() {
        UserDefaults.standard.removeObject(forKey: userProgressKey)
        userProgress = UserProgress()
        print("Kullanıcı ilerlemesi sıfırlandı.")
    }
}
