// Copyright (C) 2013-2018 ycmd contributors
//
// This file is part of ycmd.
//
// ycmd is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// ycmd is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with ycmd.  If not, see <http://www.gnu.org/licenses/>.

#ifndef TRANSLATIONUNITSTORE_H_NGN0MCKB
#define TRANSLATIONUNITSTORE_H_NGN0MCKB

#include "TranslationUnit.h"
#include "UnsavedFile.h"

#include <mutex>
#include <string>
#include <vector>
#include <memory>
#include <unordered_map>

using CXIndex = void*;

namespace std {

template <> struct hash< vector< string > > {
  // The algorithm has been taken straight from a TR1.
  // This is also the way Boost implements it.
  size_t operator()( const vector< string > &string_vector ) const {
    size_t seed = 0;
    for ( const auto &element : string_vector )  {
       seed ^= hash< string >()( element ) + ( seed << 6 ) + ( seed >> 2 );
    }
    return seed;
  }
};

} // std namespace

namespace YouCompleteMe {

class TranslationUnitStore {
public:
  YCM_EXPORT TranslationUnitStore( CXIndex clang_index );
  YCM_EXPORT ~TranslationUnitStore();
  TranslationUnitStore( const TranslationUnitStore& ) = delete;
  TranslationUnitStore& operator=( const TranslationUnitStore& ) = delete;

  // You can even call this function for the same filename from multiple
  // threads; the TU store will ensure only one TU is created.
  YCM_EXPORT std::shared_ptr< TranslationUnit > GetOrCreate(
    const std::string &filename,
    const std::vector< UnsavedFile > &unsaved_files,
    const std::vector< std::string > &flags );

  std::shared_ptr< TranslationUnit > GetOrCreate(
    const std::string &filename,
    const std::vector< UnsavedFile > &unsaved_files,
    const std::vector< std::string > &flags,
    bool &translation_unit_created );

  // Careful here! While GetOrCreate makes sure to take into account the flags
  // for the file before returning a stored TU (if the flags changed, the TU is
  // not really valid anymore and a new one should be built), this function does
  // not. You might end up getting a stale TU.
  std::shared_ptr< TranslationUnit > Get( const std::string &filename );

  bool Remove( const std::string &filename );

  void RemoveAll();

private:

  // WARNING: This accesses filename_to_translation_unit_ without a lock!
  std::shared_ptr< TranslationUnit > GetNoLock( const std::string &filename );


  using TranslationUnitForFilename =
    std::unordered_map< std::string, std::shared_ptr< TranslationUnit > >;

  using FlagsHashForFilename = std::unordered_map< std::string, std::size_t >;

  CXIndex clang_index_;
  TranslationUnitForFilename filename_to_translation_unit_;
  FlagsHashForFilename filename_to_flags_hash_;
  std::mutex filename_to_translation_unit_and_flags_mutex_;
};

} // namespace YouCompleteMe

#endif  // TRANSLATIONUNITSTORE_H_NGN0MCKB
